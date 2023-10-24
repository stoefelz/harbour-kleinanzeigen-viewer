import QtQuick 2.2
import Sailfish.Silica 1.0
import QtGraphicalEffects 1.0
import io.thp.pyotherside 1.5
import "startpage"
import "database.js" as DB

Page {
    id: searchPage
    allowedOrientations: Orientation.All

    //default searchTerm is an blank because so you get the startsite kleinanzeigen items
    property string searchTerm: " "
    //to know if there is anything to show -> when 0: Error Page
    property int resultsLength: 1
    property bool filterPageAttached
    property PageBusyIndicator busyIndicatorProperty: null
    property string previousSearchResult
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
                    filterProperties.pageNumber = 1
                    searchTerm = searchField.text
                    python.startSearch(searchField.text, filterProperties.pageNumber)
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

        delegate: ItemDelegate {}

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
                onClicked: pageStack.push(Qt.resolvedUrl("favourites/FavouriteOverview.qml"))
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
                    python.startSearch(searchTerm, filterProperties.pageNumber)
                }
            }
        }

        Python {
            id: python

            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('.'))

                setHandler('msg', function (returnMsg) {
                    console.log('python message ' + returnMsg)
                })

                importModule('get_search_entries', function () {})

                //start first "search" when opening app
                startSearch("", filterProperties.pageNumber)
            }

            onError: {
                console.log('python error: ' + traceback)
            }

            onReceived: {
                console.log('python: ' + data)
            }

            function startSearch(searchString, pageNumber) {
                //clean results with new search (== page=1)
                if (pageNumber === 1) {
                    listOfSearchResult.clear()
                    previousSearchResult = ""
                    lastSearchPage = false
                    busyIndicatorProperty.running = true
                }
                else {
                    pushupMenu.busy = true
                }

                //add search arguments as dictionary
                var filterArguments = {
                    'site_number': filterProperties.pageNumber.toString()
                }
                if(filterProperties.sorting !== "")
                    filterArguments['sorting'] = filterProperties.sorting
                if(filterProperties.seller !== "")
                    filterArguments['seller'] = filterProperties.seller
                if(filterProperties.typ !== "")
                    filterArguments['typ'] = filterProperties.typ
                if(filterProperties.minPrice !== "")
                    filterArguments['min_price'] = filterProperties.minPrice
                if(filterProperties.maxPrice !== "")
                    filterArguments['max_price'] = filterProperties.maxPrice
                if(filterProperties.zipJSONCode !== "")
                    filterArguments['zip_code_id'] = filterProperties.zipJSONCode
                if(filterProperties.zipRadius !== "")
                    filterArguments['zip_radius'] = filterProperties.zipRadius

                call('get_search_entries.get_search_entries',
                     [searchString, filterArguments],
                     function (returnValue) {
                         var resultObject = JSON.parse(returnValue)

                         if (JSON.stringify(resultObject) === previousSearchResult) {
                             lastSearchPage = true
                         }
                         else {
                             resultsLength = resultObject.length
                             for (var i = 0; i < resultObject.length; i++) {
                                 listOfSearchResult.append({
                                      "itemId": resultObject[i]["id"],
                                      "zip": resultObject[i]["zip-code"],
                                      "date": resultObject[i]["date"],
                                      "price": resultObject[i]["price"],
                                      "heading": resultObject[i]["heading"],
                                      "imageUrl": resultObject[i]["image-url"],
                                  })
                       /*          console.log(resultObject[i]["id"])
                                 console.log(resultObject[i]["zip-code"])
                                 console.log(resultObject[i]["date"])
                                 console.log(resultObject[i]["price"])
                                 console.log(resultObject[i]["heading"])
                                 console.log(resultObject[i]["image-url"])*/
                             }
                         }

                         previousSearchResult = JSON.stringify(resultObject)

                         busyIndicatorProperty.running = false
                         pushupMenu.busy = false
                     })
            }
        }

        VerticalScrollDecorator {}
    }
    onStatusChanged: {

        if (status == PageStatus.Active && !filterPageAttached) {
            pageStack.pushAttached(Qt.resolvedUrl("Filter.qml"))
            filterPageAttached = true
        }

        if (status == PageStatus.Activating && filterProperties.reloadSearch) {
            python.startSearch(searchTerm, filterProperties.pageNumber)
            filterProperties.reloadSearch = false
        }

        searchFieldProperty.focus = false
    }


}
