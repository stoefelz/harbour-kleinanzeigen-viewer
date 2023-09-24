import QtQuick 2.2
import Sailfish.Silica 1.0
import QtGraphicalEffects 1.0
import io.thp.pyotherside 1.5

SilicaFlickable {

    property int detailListLength: itemObject.details.length
    property int checkListLength: itemObject.checktags.length
    contentHeight: contentColumn.height
    function fillModels() {
        for (var i = 0; i < itemObject["small-pictures"].length; ++i) {
            pictureUrls.append({
                                    "imageUrl": itemObject["small-pictures"][i]
                                })
        }

        for (var i = 0; i < itemObject.details.length; ++i) {
            detailItemList.append({
                                        "detailDescription": itemObject.details[i].key,
                                        "detailContent": itemObject.details[i].value
                                    })
        }

        for (var i = 0; i < itemObject.checktags.length; ++i) {
            checkGridModel.append({
                                        "checkGridItem": itemObject.checktags[i]
                                    })
        }
    }
    //for loader qml -> requires following object with name "itemObject"

    //anchors.fill: parent

    //TODO schauen ob nicht verfügbar mehr
Column {
    id: contentColumn
    x: Theme.horizontalPageMargin
    width: parent.width - 2*Theme.horizontalPageMargin
    spacing: Theme.paddingMedium

    Label {
      id: marginTop
      width: parent.width
      height: Theme.paddingLarge * 1.5
    }

    // picture carussel with picture count in text format
    Item {
        height: picCarussel.height
        width: parent.width
        visible: itemObject["small-pictures"].length > 0 ? true : false

        SlideshowView {
            id: picCarussel
            height: picCarussel.width
            width: parent.width
            clip: true

            model: ListModel {
                id: pictureUrls
            }

            delegate: Image {
                id: imageItem
                source: imageUrl

                width: parent.width
                height: parent.height
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("PictureCarussel.qml"), {
                                           "bigPicUrls": itemObject["large-pictures"],
                                           "currentIndex": picCarussel.currentIndex
                        })
                    }
                }
            }

        }

        Rectangle {
            anchors.bottom: picCarussel.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: picText.contentWidth + 2 * Theme.paddingSmall
            height: picText.contentHeight + Theme.paddingSmall
            color: "#f0f8ff"
            opacity: 0.5
            radius: 10

            Label {
                id: picText
                anchors.horizontalCenter: parent.horizontalCenter
                color: "black"
                text: (picCarussel.currentIndex + 1) + "/" + itemObject["large-pictures"].length
            }
        }

    }


    Item {
        id: itemDetails
        height: heading.height + price.height + zip.height
        width: parent.width

        Label {
            id: heading
            width: parent.width
            text: itemObject.heading
            font.pixelSize: Theme.fontSizeLarge
            color: Theme.highlightColor
            wrapMode: Text.WordWrap
        }

        Label {
            id: price
            text: itemObject.price
            anchors.top: heading.bottom
            anchors.right: parent.right
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeLarge
        }

        /* // views are empty in python script
        Label {
            id: views
            text: item_array[7] + " " + qsTr("Views")
            anchors.bottom: price.bottom
            anchors.left: parent.left
            anchors.topMargin: Theme.paddingSmall
            font.pixelSize: Theme.fontSizeSmall
        }*/

        Label {
            id: date
            text: itemObject.date
            anchors.bottom: price.bottom
            font.pixelSize: Theme.fontSizeSmall
        }

        Label {
            id: zip
            text: itemObject["zip-code"]
            anchors.top: price.bottom
            font.pixelSize: Theme.fontSizeSmall
            width: parent.width
            truncationMode: TruncationMode.Fade

        }
    }

    SectionHeader {
        id: sectionHeaderDetails
        text: qsTr("Details")
        visible: detailListLength > 0 ? true : false
    }

    SilicaListView {
        id: detailList
        width: parent.width

        height: Theme.itemSizeSmall / 1.15 * detailListLength
        interactive: false

        model: ListModel {
            id: detailItemList
        }

        delegate: DetailItem {
            id: detailItem
            height: Theme.itemSizeSmall / 1.15
            label: detailDescription
            value: detailContent
        }

    }

    SectionHeader {
        id: sectionHeaderChecklist
        text: qsTr("Features")
        visible: checkListLength > 0 ? true : false
    }

    SilicaListView {
        id: checkGrid
        width: parent.width
        height: checkListLength * Theme.itemSizeExtraSmall / 1.5
        spacing: Theme.paddingSmall
        interactive: false

        model: ListModel {
            id: checkGridModel
        }

        delegate: Label {
                id: gridLabel
                text: checkGridItem
                width: parent.width
                height: Theme.itemSizeExtraSmall / 1.5
                wrapMode: Text.WordWrap
        }
    }

    SectionHeader {
        id: sectionHeaderDescription
        text: qsTr("Description")
    }


    Label {
        id: text
        width: parent.width
        text: itemObject.text
        wrapMode: Text.Wrap
    }


    SectionHeader {
        id: sectionHeaderFooter
        text: qsTr("Info")
    }

    Label {
        id: userinfo
        width: parent.width
        text: itemObject["username"] + ": " + itemObject["userinfo"] /*{
            if(item_array[0][0] == "")
                item_array[0][1]
            else
                item_array[0][0] + ": " + item_array[0][1]
        }*/
        wrapMode: Text.WordWrap
    }

    Label {
      id: marginBottom
      width: parent.width
      height: Theme.paddingLarge
    }
}

    PullDownMenu {

        MenuItem {
            text: qsTr("Open item in Browser")
            onClicked: {
                //pageStack.push(Qt.resolvedUrl("WebView.qml"), {itemUrl: itemObject.link})
                Qt.openUrlExternally(itemObject.link)
            }
        }
    }

    VerticalScrollDecorator {}

    Component.onCompleted: {
        fillModels()
        pageStack.pushAttached(Qt.resolvedUrl("WebView.qml"), {
                                   "itemUrl": itemObject.link
                               })

    }
}
