import QtQuick 2.6
import Sailfish.Silica 1.0
import "../scripts/database.js" as DB

ListItem {
    contentHeight: Theme.itemSizeHuge + 2 * Theme.paddingMedium

    //item contains image, heading for item, price and zip code
    Item {
        anchors {
            fill: parent
            leftMargin: Theme.horizontalPageMargin
            rightMargin: Theme.horizontalPageMargin
            topMargin: Theme.paddingMedium
            bottomMargin: Theme.paddingMedium
        }

        Image {
            id: imageItem
            height: Theme.itemSizeHuge
            width: imageItem.height
            asynchronous: true
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectCrop
            sourceSize.width: width
            sourceSize.height: height
            source: imageUrl
            cache: true
            smooth: false
        }

        //heading -> at kleinanzeigen the headings are max 70 characters (2022)
        Label {
            width: parent.width - imageItem.width
            anchors {
                top: parent.top
                bottom: priceItem.top
                left: imageItem.right
                leftMargin: Theme.paddingMedium
            }

            text: heading
            renderType: Text.NativeRendering
            font.pixelSize: Theme.fontSizeSmall
            wrapMode: Text.Wrap
            maximumLineCount: 3
            elide: Text.ElideRight
        }

        //zip code
        Label {
            anchors {
                bottom: parent.bottom
                left: imageItem.right
                right: priceItem.left
                leftMargin: Theme.paddingMedium
                rightMargin: Theme.paddingMedium
            }
            text: zip
            font.pixelSize: Theme.fontSizeTiny
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            elide: Text.ElideRight
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
        if(!offline)
            pageStack.push(Qt.resolvedUrl("../pages/Item.qml"), {"itemId": itemId})
    }
    menu: ContextMenu {
        on_OpenChanged: {
            if (open) {
                watchlistItem.isInWatchlist = DB.existsWatchlistItem(itemId)
            }
        }
        MenuItem {
            id: watchlistItem
            property bool isInWatchlist: false
            property bool initialized: false
            text: isInWatchlist ? qsTr("Remove from watchlist") : qsTr("Add to watchlist")
            onClicked: {
                if(isInWatchlist) {
                   DB.deleteWatchlistItem(itemId)
                    isInWatchlist = false
                }
                else {
                    //smaller image size for db
                    var smallerImage = imageUrl.replace("$_59.AUTO", "$_35.AUTO")
                    DB.storeWatchlistItem(itemId, heading, zip, price, smallerImage)
                    isInWatchlist = true
                }
            }
            //Component.onCompleted: isInWatchlist = DB.existsWatchlistItem(itemId)
            Component.onCompleted: {
                if (!initialized && visible) {
                    isInWatchlist = DB.existsWatchlistItem(itemId)
                    initialized = true
                }
            }
        }
    }
}
