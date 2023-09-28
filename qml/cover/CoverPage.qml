import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {

    Image {
        width: parent.width / 2
        height: width
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        rotation: 3
        fillMode: Image.PreserveAspectCrop
        opacity: 0.8
        source: "harbour-kleinanzeigen-viewer.png"
    }

    Label {
        width: parent.width - 2 * Theme.horizontalPageMargin
           anchors {
               horizontalCenter: parent.horizontalCenter
               top: parent.top
               topMargin: Theme.paddingLarge

           }
           color: Theme.highlightColor
           text: qsTr("Kleinanzeigen")
           font.weight: Font.DemiBold
           wrapMode: Text.WordWrap

       }

    CoverActionList {
        CoverAction {
            iconSource: "image://theme/icon-cover-search"
            onTriggered: {
                while(pageStack.depth > 1) {
                    pageStack.pop()
                    pageStack.completeAnimation()
                }
                appWindow.activate()
                pageStack.currentPage.focusSearch()
            }
        }
    }

}
