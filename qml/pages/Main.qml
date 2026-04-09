import QtQuick 2.6
import Sailfish.Silica 1.0
import QtGraphicalEffects 1.0
import io.thp.pyotherside 1.5
import "../components"

Page {
    id: searchPage
    allowedOrientations: Orientation.All
    //default searchTerm is an blank because so you get the startsite kleinanzeigen items
    property string searchTerm: " "
    //to know if there is anything to show
    property int resultsLength: 0
    property bool filterPageAttached
    property string previousSearchResult
    property bool lastSearchPage
    //to block reloading further results while already loading
    property bool loadingFinished: true

    function focusSearch() {
        searchFieldProperty.forceActiveFocus()
    }

    //TODO null abfrage
    //TODO lade symbol -> bis pythonoterside zeichen gibt, dass fertig
    SilicaListView {
        anchors.fill: parent
        //load automatic next results when on page end
        onAtYEndChanged: {
            if (atYEnd && loadingFinished && !lastSearchPage && resultsLength > 0) {
                loadingFinished = false
                filterProperties.pageNumber += 1
                python.startSearch(searchTerm, filterProperties.pageNumber)
            }
        }

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
                    loadingFinished = false
                    python.startSearch(searchField.text, filterProperties.pageNumber)
                }

                //set searchField as property
                Component.onCompleted: searchFieldProperty = searchField
            }

            ViewPlaceholder {
                enabled: resultsLength <= 0 && (busyIndicator.running == false || offline)
                text: offline ? qsTr("No internet connection") : qsTr("Search Error")
                hintText: offline ? qsTr("Check Wifi or mobile data") : qsTr("Maybe there are no results")
            }
        }

        model: ListModel {
            id: listOfSearchResult
        }

        delegate: SearchListDelegate {}

        //loading animation for automatic loading next page
        Rectangle {
            id: loadingBar
            property bool isActive: false
            visible: loadingBar.isActive
            color: Theme.highlightBackgroundColor
            width: parent.width
            height: Theme.paddingSmall * 1.33
            anchors.bottom: parent.bottom
            //for animation performance
            antialiasing: true
            layer.enabled: true
            layer.smooth: true
            layer.effect: null

            NumberAnimation on x {
                from: -loadingBar.width
                to: parent.width
                duration: 1000
                loops: Animation.Infinite
                running: loadingBar.isActive
            }
        }

        PullDownMenu {
            id: pullDownMenu
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

        Python {
            id: python

            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('../kleinanzeigen_parser/'))

                setHandler('msg', function (returnMsg) {
                    console.log('python message ' + returnMsg)
                })

                importModule('get_search_entries', function () {})
                startSearch("", filterProperties.pageNumber)
            }

            onError: {
                console.log('python error: ' + traceback)
            }

            onReceived: {
                console.log('python: ' + data)
            }

            function startSearch(searchString, pageNumber) {
                if(offline) {
                    return
                }

                //clean results with new search (== page=1)
                if (pageNumber === 1) {
                    listOfSearchResult.clear()
                    previousSearchResult = ""
                    lastSearchPage = false
                    busyIndicator.running = true
                }
                else {
                    loadingBar.isActive = true
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
                if(filterProperties.categoryId !== "")
                    filterArguments['category'] = filterProperties.categoryId
                if(filterProperties.buynow)
                    filterArguments['buynow'] = "true"
                else
                    filterArguments['buynow'] = "false"
                if(filterProperties.shipping != "")
                    filterArguments['shipping'] = filterProperties.shipping

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
                                 /*console.log(resultObject[i]["id"])
                                 console.log(resultObject[i]["zip-code"])
                                 console.log(resultObject[i]["date"])
                                 console.log(resultObject[i]["price"])
                                 console.log(resultObject[i]["heading"])
                                 console.log(resultObject[i]["image-url"])*/
                             }
                         }

                         previousSearchResult = JSON.stringify(resultObject)
                         busyIndicator.running = false
                         loadingFinished = true
                         loadingBar.isActive = false
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

        if (status == PageStatus.Active && filterProperties.reloadSearch && loadingFinished) {
            loadingFinished = false
            python.startSearch(searchTerm, filterProperties.pageNumber)
            filterProperties.reloadSearch = false
        }

        searchFieldProperty.focus = false
    }

    PageBusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: true
        visible: running
    }


}
