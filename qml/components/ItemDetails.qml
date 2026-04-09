import QtQuick 2.6
import Sailfish.Silica 1.0
import QtGraphicalEffects 1.0
import io.thp.pyotherside 1.5
import "../scripts/database.js" as DB

SilicaFlickable {

    property int detailListLength: itemObject.details.length
    property int checkListLength: itemObject.checktags.length
    contentHeight: itemContent.height
    function fillModels() {
        coverName = itemObject.heading
        coverImage = itemObject["small-pictures"][0] ? itemObject["small-pictures"][0] : ""

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

    Column {
        id: itemContent
        x: Theme.horizontalPageMargin
        width: parent.width - 2 * Theme.horizontalPageMargin
        spacing: Theme.paddingMedium

        Label {
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
                            pageStack.push(Qt.resolvedUrl(
                               "PictureCarussel.qml"), {
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
            height: heading.height + price.height + zip.height
            width: parent.width

            Label {
                property string status: {
                    if(itemObject.status === "deleted")
                        return qsTr("DELETED ")
                    else if (itemObject.status === "paused")
                        return qsTr("RESERVED ")
                    else
                        return ""
                }

                id: heading
                width: parent.width
                text: status + itemObject.heading
                font.pixelSize: Theme.fontSizeLarge
                color: status === "" ? Theme.highlightColor : "#FF0000"
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

            Label {
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

        Item {
            width: parent.width
            height: shipping.height;

            Label {
                id: direktKaufen
                anchors.left: parent.left
                text: qsTr("✅ Direkt kaufen")
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.secondaryHighlightColor
                visible: itemObject.buynow
            }

            Label {
                id: shipping
                anchors.right: parent.right
                text: itemObject["shipping"]
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.secondaryHighlightColor
            }
        }

        Item {
            width: parent.width
            height: buyerprotection.visible ? buyerprotection.height : 0
            Label {
                id: buyerprotection
                anchors.right: parent.right
                text: qsTr("+ buyers protection ") + itemObject.buynowfee/100 + " €"
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.secondaryHighlightColor
                visible: itemObject["buynowfee"] !== ""
            }
        }

        SectionHeader {
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
            width: parent.width
            text: itemObject.text
            wrapMode: Text.Wrap
        }

        SectionHeader {
            text: qsTr("Info")
        }

        Label {
            id: userinfo
            width: parent.width
            //commercial users does not have a username
            text: itemObject["username"] === "" ? itemObject["userinfo"] : itemObject["username"]
                                                  + ": " + itemObject["userinfo"]
            wrapMode: Text.WordWrap
        }

        Label {
            width: parent.width
            text: itemObject["userbadges"]
            wrapMode: Text.WordWrap
            visible: itemObject["userbadges"] !== ""
        }

        Label {
            width: parent.width
            height: Theme.paddingLarge
        }
    }

    PullDownMenu {


        MenuItem {
            text: qsTr("Open item in Browser")
            onClicked: Qt.openUrlExternally(itemObject.link)
        }

        MenuItem {
            property bool isInWatchlist
            text: isInWatchlist ? qsTr("Remove from watchlist") : qsTr("Add to watchlist")
            onClicked: {
                if(isInWatchlist) {
                   DB.deleteWatchlistItem(itemObject["item-id"])
                    isInWatchlist = false
                }
                else {
                    //smaller image size for db
                    var smallImage = itemObject["small-pictures"][0]
                    var smallerImage = smallImage.replace("$_59.AUTO", "$_35.AUTO")
                    DB.storeWatchlistItem(itemObject["item-id"], itemObject["heading"], itemObject["zip-code"], itemObject["price"], smallerImage)
                    isInWatchlist = true
                }
            }
            Component.onCompleted: isInWatchlist =  DB.existsWatchlistItem(itemObject["item-id"])

        }

    }

    VerticalScrollDecorator {}

    Component.onCompleted: {
        fillModels()
    }
}
