import QtQuick 2.0
import Sailfish.Silica 1.0

BackgroundItem {
    width: parent.width
    Row {
        width: parent.width

        Column {
            width: parent.width
            Row {
                width: parent.width

                x: Theme.horizontalPageMargin
                Label {
                    id: description
                    text: descriptionText + " "

                }
                Label {
                    width: parent.width - description.width - reset.width - 2*Theme.horizontalPageMargin
                    color: Theme.highlightColor
                    text: categoryDetailsDescription
                    truncationMode: TruncationMode.Fade
                }
            }
            Label {
                x: Theme.horizontalPageMargin
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeExtraSmallBase
                text: categoryHint
            }
        }
    }

    IconButton {
        id: reset
        visible: resetVisible
        icon.source: "image://theme/icon-m-clear"
        anchors.right: parent.right
        onClicked: resetFunction()
    }

}
