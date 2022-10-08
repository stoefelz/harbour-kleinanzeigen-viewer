import QtQuick 2.2
import Sailfish.Silica 1.0
import QtGraphicalEffects 1.0
import io.thp.pyotherside 1.5

Page {
    allowedOrientations: Orientation.All
    property int page_number: 1
    property string search_term: " "
    property int results_length: 1
    property bool page_attached: false

    PageBusyIndicator {
        id: busy_indicator
        running: true
    }

//TODO null abfrage
    //TODO lade symbol -> bis pythonoterside zeichen gibt, dass fertig
    SilicaListView {

        anchors.fill: parent
//TODO offline modus
        //header with search field and heading
        header: Column {
            id: header_column
            width: parent.width

            PageHeader {
                id: header
                title: qsTr("Viewer")

            }

            SearchField {
                id: search_field
                width: parent.width

                placeholderText: qsTr("Search your product")
                EnterKey.enabled: text.length > 0
                EnterKey.iconSource: "image://theme/icon-m-search"

                //click should initiate new search -> keyboard should loss focus and properties set to new search
                EnterKey.onClicked: {

                    focus = false
                    page_number = 1
                    search_term = search_field.text
                    python.start_search(search_field.text, page_number)


                }

                //set search_field as property
                Component.onCompleted: search_field_property = search_field

            }

            ViewPlaceholder {
                id: no_search_entries
                enabled: {
                    if(results_length <= 0 && busy_indicator.running == false)
                        true
                    else
                        false
                }
                text: qsTr("Search Error")
                hintText: qsTr("Maybe there are no results")
            }
        }


        model: ListModel { id: list_of_search_result }

        delegate: ListItem {
            id: search_result_item
            //yeah, i'll burn in hell
            contentHeight: price_item.height * 5

            clip: true

            //rectangle contains image, heading for item, price and zip code
            Rectangle {
                width: parent.width
                color: "transparent"
                //margin for left and right of screen and top and bottom of listitem
                anchors {
                    left: parent.left; leftMargin: Theme.horizontalPageMargin
                    right: parent.right; rightMargin: Theme.horizontalPageMargin
                    top: parent.top; topMargin: Theme.paddingMedium
                    bottom: parent.bottom; bottomMargin: Theme.paddingMedium
                }

                Image {
                    id: image_item
                    source: image_url
                    height: Theme.itemSizeHuge
                    anchors.verticalCenter: parent.verticalCenter
                    width: image_item.height
                    fillMode: Image.PreserveAspectCrop
                    //image should have rounded corners
                    layer.enabled: true
                        layer.effect: OpacityMask {
                            maskSource: mask
                        }
                }

                //mask for image with rounded corners
                Rectangle {
                    id: mask
                    height: image_item.height
                    width: image_item.height
                    radius: 5
                    visible: false
                }

                //heading -> at ebay-kleinanzeigen the headings are max 70 characters (2022)
                Label {
                    id: heading_item
                    width: parent.width - image_item.width
                    //these anchors are from hell
                    anchors {
                        top: parent.top
                        bottom: price_item.top
                        left: image_item.right; leftMargin: Theme.paddingMedium
                    }

                    text: heading
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.Wrap
                    //you cant see overflow with clip enabled
                    clip: true

                }

                //zip code
                Label {
                    id: zip_code_item

                    width: parent.width - image_item.width - price_item.width - 2 * Theme.paddingMedium
                    anchors.bottom: parent.bottom
                    anchors.left: image_item.right
                    anchors.leftMargin: Theme.paddingMedium
                    text: zip
                    font.pixelSize: Theme.fontSizeTiny
                    clip: true
                }

                //price
                Label {
                    id: price_item
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    text: price
                    color: Theme.highlightColor
                }

            }

            //click on ListItem
            onClicked: {
                //go to item page
                pageStack.push(Qt.resolvedUrl("SecondPage.qml"), {item_id: item_id})

            }

            menu: ContextMenu {
                 MenuItem {
                     text: qsTr("Open in browser")
                     onClicked: Qt.openUrlExternally("https://www.ebay-kleinanzeigen.de/s-anzeige/" + item_id);
                 }
            }
        }

        PullDownMenu {

            MenuItem {
                text: qsTr("About")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("About_Page.qml"))
                }
            }

            MenuItem {
                text: qsTr("Delete all filter")
                onClicked: {
                    sorting = ""
                    seller = ""
                    typ = ""
                    min_price = 0
                    max_price = 1000000

                    python.start_search(search_term, page_number)
                }

            }

            MenuItem {
                text: qsTr("Focus Search Field")
                onClicked: {
                    search_field_property.forceActiveFocus()
                }
            }


        }

        PushUpMenu {
            id: pushup_menu
            quickSelect: true

            MenuItem {
                text: qsTr("Load more")

                //TODO nachladen muss begrenzt werden

                onClicked: {
                    page_number += 1
                    //TODO schlecht, weil in searchfield kann schon was anderes stehen, aber man möchte beim alten weiter
                    python.start_search(search_term, page_number)
                }
            }
        }


        Python {
            id: python

            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('.'))

                setHandler('msg', function(return_msg) {
                    console.log('python message ' + return_msg)
                })

                importModule('get_search_entries', function() {})

                //start first "search" when opening app
                start_search("", page_number)
            }

            onError: {
                console.log('python error: ' + traceback);
            }

            onReceived: {
                console.log('python: ' + data);
            }

            function start_search(search_string, site) {
                if(page_number <= 1)
                    busy_indicator.running = true
                else
                    pushup_menu.busy = true

                //TODO liste_search-result leeren -> aber nicht bei seite 2 anzeigen, dann sollte anfoch angefügt werden
                if(site === 1)
                    list_of_search_result.clear()
                call('get_search_entries.get_search_entries', [search_string, page_number.toString(), sorting, seller, typ, min_price, max_price], function(return_value) {
                    var result_array = JSON.parse(return_value)
                    results_length = result_array.length
                    for(var i = 0; i < result_array.length; i++) {
                        list_of_search_result.append({"item_id": result_array[i][0], "zip": result_array[i][4], "date": result_array[i][5], "price": result_array[i][3],"heading": result_array[i][1], "image_url": result_array[i][6]})
                    }
                    busy_indicator.running = false
                    pushup_menu.busy = false
                })

            }

        }

        VerticalScrollDecorator {}

    }
    onStatusChanged:  {


        if (status == PageStatus.Active && !page_attached) {
            pageStack.pushAttached(Qt.resolvedUrl("filter_page.qml"))
            page_attached = true
        }

        if(status == PageStatus.Active && reload_search) {
            python.start_search(search_term, page_number)
            reload_search = false
        }


    }


}
