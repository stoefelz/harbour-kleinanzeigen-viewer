import QtQuick 2.2
import Sailfish.Silica 1.0
import QtGraphicalEffects 1.0
import io.thp.pyotherside 1.5

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

        delegate: ListItem {
            //yeah, i'll burn in hell
            contentHeight: priceItem.height * 5
            clip: true

            //rectangle contains image, heading for item, price and zip code
            Rectangle {
                width: parent.width - 2*Theme.horizontalPageMargin
                color: "transparent"
                //margin for left and right of screen and top and bottom of listitem
                x: Theme.horizontalPageMargin
                anchors {
                    top: parent.top
                    topMargin: Theme.paddingMedium
                    bottom: parent.bottom
                    bottomMargin: Theme.paddingMedium
                }

                Image {
                    id: imageItem
                    source: imageUrl
                    height: Theme.itemSizeHuge
                    anchors.verticalCenter: parent.verticalCenter
                    width: imageItem.height
                    fillMode: Image.PreserveAspectCrop
                    //image should have rounded corners
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: roundMask
                    }
                }

                //mask for image with rounded corners
                Rectangle {
                    id: roundMask
                    height: imageItem.height
                    width: imageItem.height
                    radius: 5
                    visible: false
                }

                //heading -> at kleinanzeigen the headings are max 70 characters (2022)
                Label {
                    width: parent.width - imageItem.width
                    //these anchors are from hell
                    anchors {
                        top: parent.top
                        bottom: priceItem.top
                        left: imageItem.right
                        leftMargin: Theme.paddingMedium
                    }

                    text: heading
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.Wrap
                    //you cant see overflow with clip enabled
                    clip: true
                }

                //zip code
                Label {
                    width: parent.width - imageItem.width - priceItem.width
                           - 2 * Theme.paddingMedium
                    anchors.bottom: parent.bottom
                    anchors.left: imageItem.right
                    anchors.leftMargin: Theme.paddingMedium
                    text: zip
                    font.pixelSize: Theme.fontSizeTiny
                    clip: true
                }

                //price
                Label {
                    id: priceItem
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    text: price
                    color: Theme.highlightColor
                }
            }

            //click on ListItem
            onClicked: {
                //go to item page
                pageStack.push(Qt.resolvedUrl("LoadItem.qml"), {"itemId": itemId})
            }

            menu: ContextMenu {
                MenuItem {
                    text: qsTr("Open in browser")
                    onClicked: Qt.openUrlExternally(websiteUrl + "/s-anzeige/" + itemId)}
            }
        }

        PullDownMenu {

            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("About.qml"))

            }

            MenuItem {
                text: qsTr("Focus Search Field")
                onClicked: searchFieldProperty.forceActiveFocus()
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

        if (status == PageStatus.Active && filterProperties.reloadSearch) {
            python.startSearch(searchTerm, filterProperties.pageNumber)
            filterProperties.reloadSearch = false
        }

        searchFieldProperty.focus = false
    }


}
