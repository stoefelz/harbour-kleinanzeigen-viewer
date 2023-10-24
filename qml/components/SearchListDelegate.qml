import QtQuick 2.0
import Sailfish.Silica 1.0
import QtGraphicalEffects 1.0

ListItem {
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
            pageStack.push(Qt.resolvedUrl("../pages/Item.qml"), {"itemId": itemId})
        }

}
