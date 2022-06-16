import QtQuick 2.2
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5

SilicaFlickable {

    function fill_models() {
        for(var i = 0; i < item_array[2].length; ++i) {
            picture_urls.append({"image_url": item_array[2][i]})
        }
    }
    //for loader qml -> requires following array with name "item_array"
    //[[username, userinfo], [big_pics, .. , big_pics], [small_pics, .., small_pics], heading, price, zip, date, views, [[detaillistright, detaillistleft], .., [detaillistright, detaillistleft]], [checktags, .. , checktags], text, link]
    //          0                       1                               2                3      4       5   6       7                                       8                                                           9         10    11

    //TODO datei umbenennen ist keine Silivaview sondern flickable
    anchors.fill: parent
    contentHeight: header.height + item_details.height + item_footer.height + pic_carussel.height + section_header_description.height



    //TODO immer checken ob arrayplatz leer, weil wenn, dann zeug net anzeigen
//TODO schauen ob nicht verfügbar mehr
    PageHeader {
        id: header
        anchors.top: parent.top
        title: qsTr("Viewer")
    }

    SlideshowView {
        id: pic_carussel
        height:  pic_carussel.width
        width: parent.width
        clip: true
        anchors {
            top: header.bottom
            right: parent.right; rightMargin: Theme.horizontalPageMargin
            left: parent.left; leftMargin: Theme.horizontalPageMargin

        }

        model: ListModel { id: picture_urls }

        delegate: Image {
            id: image_item
            source: image_url

            width: parent.width
            height: parent.height
            fillMode: Image.PreserveAspectFit

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("PictureCarussel.qml"), {big_pic_urls: item_array[1], current_index: pic_carussel.currentIndex})
                }
            }
        }
    }


    Rectangle {
        id: item_details
        height: heading.height + price.height + zip.height
        color: "transparent"

        anchors {
            top: pic_carussel.bottom; topMargin: Theme.paddingLarge
            left: parent.left; leftMargin: Theme.horizontalPageMargin
            right: parent.right; rightMargin: Theme.horizontalPageMargin
        }

        Label {
            id: heading
            width: parent.width
            text: item_array[3]
            font.pixelSize: Theme.fontSizeLarge
            color: Theme.highlightColor
            wrapMode: Text.WordWrap
        }

        Label {
            id: price
            text: item_array[4]
            anchors.top: heading.bottom
            anchors.right: parent.right
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeLarge
        }

        Label {
            id: views
            text: item_array[7] + " " + qsTr("Views")
            anchors.bottom: price.bottom
            anchors.left: parent.left
            anchors.topMargin: Theme.paddingSmall
            font.pixelSize: Theme.fontSizeSmall
        }

        Label {
            id: date
            text: item_array[6]
            anchors.bottom: price.bottom
            anchors.left: views.right
            anchors.topMargin: Theme.paddingSmall
            anchors.leftMargin: Theme.paddingMedium
            font.pixelSize: Theme.fontSizeSmall
        }

        Label {
            id: zip
            text: item_array[5]
            anchors.top: price.bottom
            anchors.left: parent.left
            font.pixelSize: Theme.fontSizeSmall
            width: parent.width
            wrapMode: Text.WordWrap
        }

    }

    SectionHeader {
        id: section_header_description
        text: qsTr("Description")
        anchors.top: item_details.bottom
    }

    Rectangle {
        id: item_footer
        height: text.height + linkbutton.height + userinfo.height
        color: "transparent"

        anchors {
            top: section_header_description.bottom
            left: parent.left; leftMargin: Theme.horizontalPageMargin
            right: parent.right; rightMargin: Theme.horizontalPageMargin
        }


        Label {
            id: text
            width: parent.width
            text: item_array[10]
            wrapMode: Text.WordWrap
        }

        Button {
            id: linkbutton
            anchors {
                top: text.bottom
                horizontalCenter: parent.horizontalCenter
            }

            text: qsTr("Link to Item")
            onClicked: {
                Qt.openUrlExternally(item_array[11]);
            }


        }

        Rectangle {
            id: userinfo
            //TODO i dont know why
            height: userinfo_text.height * 2
            anchors {
                top: linkbutton.bottom
            }

            Label {
                id: userinfo_text
                text: item_array[0][0] + ": " + item_array[0][1]
            }
        }
    }


//        model: ListModel { id: list_of_search_result }

//        delegate: ListItem {
//            id: search_result_item
//            contentHeight: Theme.itemSizeHuge
//            clip: true

//            //rectangle contains image, heading for item, price and zip code
//            Rectangle {
//                width: parent.width
//                color: "transparent"
//                //margin for left and right of screen and top and bottom of listitem
//                anchors {
//                    left: parent.left; leftMargin: Theme.horizontalPageMargin
//                    right: parent.right; rightMargin: Theme.horizontalPageMargin
//                    top: parent.top; topMargin: Theme.paddingMedium
//                    bottom: parent.bottom; bottomMargin: Theme.paddingMedium
//                }

//                Image {
//                    id: image_item
//                    source: image_url
//                    height: parent.height
//                    width: image_item.height
//                    fillMode: Image.PreserveAspectCrop
//                    //clip: true
//                    //image should have rounded corners
//                    layer.enabled: true
//                        layer.effect: OpacityMask {
//                            maskSource: mask
//                        }
//                }

//                //mask for image with rounded corners
//                Rectangle {
//                    id: mask
//                    height: image_item.height
//                    width: image_item.height
//                    radius: 5
//                    visible: false
//                }

//                //heading -> at ebay-kleinanzeigen the headings are max 70 characters (2022)
//                Label {
//                    id: heading_item

//                    width: parent.width - image_item.width
//                    anchors {
//                        top: parent.top
//                        bottom: price_item.top
//                        left: image_item.right; leftMargin: Theme.paddingMedium
//                    }

//                    text: heading
//                    font.pixelSize: Theme.fontSizeSmall
//                    wrapMode: Text.WordWrap
//                    clip: true
//                }

//                //zip code
//                Label {
//                    id: zip_code_item

//                    width: parent.width - image_item.width - price_item.width - 2 * Theme.paddingMedium
//                    anchors.bottom: image_item.bottom
//                    anchors.left: image_item.right
//                    anchors.leftMargin: Theme.paddingMedium
//                    anchors.bottomMargin: Theme.paddingSmall
//                    text: zip
//                    font.pixelSize: Theme.fontSizeTiny
//                    //wrapMode: "WordWrap"
//                    clip: true
//                }

//                //price
//                Label {
//                    id: price_item
//                    anchors.right: parent.right
//                    anchors.bottom: parent.bottom
//                    text: price
//                    color: Theme.highlightColor
//                }

//            }

//            click on ListItem
//            onClicked: {
//                //go to item page
//                pageStack.push(Qt.resolvedUrl("SecondPage.qml"), {id: item_id})

//            }
//        }

    PullDownMenu {

        MenuItem {
            text: qsTr("Link to Item")
        }
        MenuItem {
            text: qsTr("Reload")
        }

    }



    VerticalScrollDecorator {}

    Component.onCompleted: {
        fill_models();
    }

}
