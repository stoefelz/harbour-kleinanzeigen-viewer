import QtQuick 2.2
import Sailfish.Silica 1.0
import QtGraphicalEffects 1.0
import io.thp.pyotherside 1.5
import "../components"
import "../scripts/kleinanzeigenApi.js" as API


Page {
    id: searchPage
    allowedOrientations: Orientation.All

    //default searchTerm is an blank because so you get the startsite kleinanzeigen items
    property string searchTerm: " "
    //to know if there is anything to show -> when 0: Error Page
    property int resultsLength: 1
    property bool filterPageAttached
    property PageBusyIndicator busyIndicatorProperty: null
    property bool lastSearchPage

    function focusSearch() {
        searchFieldProperty.forceActiveFocus()
    }

    //TODO -> no picture
    //TODO null abfrage
    //TODO lade symbol -> bis pythonoterside zeichen gibt, dass fertig
    SilicaListView {
        anchors.fill: parent

        //TODO offline modus
        //header with search field and heading
        header: Column {
            width: parent.width

            PageHeader {
                title: qsTr("Items")
            }

            SearchField {
                id: searchField
                width: parent.width

                placeholderText: qsTr("Search your product")
                EnterKey.enabled: text.length > 0
                EnterKey.iconSource: "image://theme/icon-m-search"

                //click should initiate new search -> keyboard should loss focus and properties set to new search
                EnterKey.onClicked: {
                    focus = false
                    filterProperties.pageNumber = 0
                    searchTerm = searchField.text
                    startSearch(searchTerm)
                }

                //set searchField as property
                Component.onCompleted: searchFieldProperty = searchField
            }

            PageBusyIndicator {
                id: busyIndicator
                running: true
                visible: running ? true : false

                Component.onCompleted: busyIndicatorProperty = busyIndicator
            }

            ViewPlaceholder {
                enabled: (resultsLength <= 0 && busyIndicator.running == false) ? true : false
                text: qsTr("Search Error")
                hintText: qsTr("Maybe there are no results")
            }
        }

        model: ListModel {
            id: listOfSearchResult
     }

        delegate: SearchListDelegate {}

        PullDownMenu {

            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))

            }
            MenuItem {
                text: qsTr("Focus Search Field")
                onClicked: searchFieldProperty.forceActiveFocus()
            }
            MenuItem {
                text: qsTr("Watchlist")
                onClicked: pageStack.push(Qt.resolvedUrl("Watchlist.qml"))
            }

        }

        PushUpMenu {
            id: pushupMenu
            quickSelect: true

            MenuItem {
                id: loadNextPage
                text: enabled ? qsTr("Load more") : qsTr("No more results")
                enabled:(resultsLength > 0 && busyIndicatorProperty.running === false && lastSearchPage === false) ? true : false

                onClicked: {
                    filterProperties.pageNumber += 1
                    //TODO schlecht, weil in searchfield kann schon was anderes stehen, aber man möchte beim alten weiter
                    startSearch(searchTerm)
                }
            }
        }

        VerticalScrollDecorator {}
    }
    onStatusChanged: {

        if (status == PageStatus.Active && !filterPageAttached) {
            pageStack.pushAttached(Qt.resolvedUrl("Filter.qml"))
            filterPageAttached = true
        }

        if (status == PageStatus.Active && filterProperties.reloadSearch) {
           /******  startSearch(searchTerm, filterProperties.pageNumber)***********************************************************************************************/
            filterProperties.reloadSearch = false
        }

        searchFieldProperty.focus = false
    }

    Connections {
            target: appDetails

            onKeyChanged: {
                startSearch(searchTerm)
            }

        }

    function startSearch(searchTerm) {
        if (filterProperties.pageNumber === 0) {
            listOfSearchResult.clear()
            lastSearchPage = false
            busyIndicatorProperty.running = true
        }
        else {
            pushupMenu.busy = true
        }

        var searchString = 'ads.json?_in=id,title,description,displayoptions,start-date-time,category.id,category.localized_name,ad-address.state,ad-address.zip-code,price,pictures,link,features-active,search-distance,negotiation-enabled,attributes,medias,medias.media,medias.media.title,medias.media.media-link,buy-now,placeholder-image-present,store-id,store-title'
        var searchParameterString = '&q=' + searchTerm + '&page=' + filterProperties.pageNumber;

        if(filterProperties.categoryId !== "")
            searchParameterString += '&categoryId=' + filterProperties.categoryId

        searchParameterString += '&sortType=' + possibleFilterValues.sortingValues[filterProperties.sorting]

        if(filterProperties.typ !== "")
            searchParameterString += '&adType=' + filterProperties.typ
        if(filterProperties.seller !== "")
            searchParameterString += '&posterType=' + filterProperties.seller

        searchParameterString += '&size=31'

        if(filterProperties.zipJSONCode !== "")
            searchParameterString += '&locationId=' + filterProperties.zipJSONCode

            searchParameterString += '&pictureRequired=false'
        if(filterProperties.zipRadius !== "")
            searchParameterString += '&distance=' + filterProperties.zipRadius
        if(filterProperties.minPrice !== "")
            searchParameterString += '&minPrice=' + filterProperties.minPrice
        if(filterProperties.maxPrice !== "")
            searchParameterString += '&maxPrice=' + filterProperties.maxPrice

        searchParameterString += '&includeTopAds=false'
        searchParameterString += '&attributes=' + ''

        if(filterProperties.buynowOnly)
            searchParameterString += '&buyNowOnly=true'
        if(filterProperties.shippingCarrier !== 0)
            searchParameterString += '&shippingCarrier=' + possibleFilterValues[filterProperties.shippingCarrier]
        if(filterProperties.shipping === true)
            searchParameterString += '&shippable=1'
        else if(filterProperties.shipping === false)
            searchParameterString += '&shippable=0'

        searchParameterString += '&limitTotalResultCount=true'

        API.kleinanzeigenGetRequest(searchString + searchParameterString, appDetails.name, appDetails.key, function(response) {


            if(response['{http://www.ebayclassifiedsgroup.com/schema/ad/v1}ads']['value']['ad'] === undefined) {
   console.log("nix")
                resultsLength = 0
                busyIndicatorProperty.running = false
                return
            }
            var adArray = response['{http://www.ebayclassifiedsgroup.com/schema/ad/v1}ads']['value']['ad']
            resultsLength = response['{http://www.ebayclassifiedsgroup.com/schema/ad/v1}ads']['value']['ad'].length

            for (var i = 0; i < resultsLength; i++) {
                listOfSearchResult.append({
                     "itemId": adArray[i]["id"],
                     "zip": adArray[i]["ad-address"]["zip-code"]["value"] + " " + adArray[i]["ad-address"]["state"]["value"],
                     "date": adArray[i]["start-date-time"]["value"],
                     "price": adArray[i]["price"] && adArray[i]["price"]["amount"] ? adArray[i]["price"]["amount"]["value"] + '€' : 'KEIN PREIS',
                     "heading": adArray[i]["title"]["value"],
                     "imageUrl": adArray[i]["pictures"] ? adArray[i]["pictures"]["picture"][0]["link"]["0"]["href"] : 'https://www.gravatar.com/avatar/b34f1987522cca72e19a9418fbacf172?s=64&d=identicon&r=PG',
                 })
            }

            if(resultsLength === 0) {
                lastSearchPage = true
            }

            busyIndicatorProperty.running = false
            pushupMenu.busy = false


        })

    }

}


