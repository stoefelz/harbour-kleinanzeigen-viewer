import QtQuick 2.6
import Sailfish.Silica 1.0

CoverBackground {

    function checkPageStack(objectName) {
        if(pageStack.currentPage && pageStack.currentPage.objectName === objectName) {
            return true
        }
        return false
    }

    Image {
        id: coverImage
        width: (checkPageStack("ItemPage") && pageStack.currentPage.coverImage !== "")
                   ? parent.width / 1.6
                   : parent.width / 2
        height: width
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: Theme.paddingSmall
        }
        rotation: 3
        fillMode: Image.PreserveAspectFit
        opacity: 0.9
        source: {
            //for updating on new page
            var dummy = pageStack.depth;
            if (checkPageStack("ItemPage") && pageStack.currentPage.coverImage !== "") {
                return pageStack.currentPage.coverImage
            }
            return "harbour-kleinanzeigen-viewer.png";
        }
    }

    // white border for items
    Rectangle {
        width: coverImage.paintedWidth * 1.15
        height: coverImage.paintedHeight * 1.15
        anchors {
            horizontalCenter: coverImage.horizontalCenter
            verticalCenter: coverImage.verticalCenter
        }
        rotation: coverImage.rotation
        color: "white"
        z: coverImage.z - 1
        visible: checkPageStack("ItemPage") && pageStack.currentPage.coverImage !== ""
    }

    Label {
        width: parent.width - 2 * Theme.horizontalPageMargin
           anchors {
               horizontalCenter: parent.horizontalCenter
               top: parent.top
               topMargin: Theme.paddingLarge
           }
           color: Theme.highlightColor
           text: {
               var dummy = pageStack.depth;
               if (checkPageStack("ItemPage")) {
                   return pageStack.currentPage.coverName
               }
               else if(checkPageStack("MainPage") && pageStack.currentPage.searchTerm !== "" && pageStack.currentPage.searchTerm !== " ") {
                   return pageStack.currentPage.searchTerm
               }
               return qsTr("Kleinanzeigen");
           }
           font.weight: Font.DemiBold
           wrapMode: Text.WrapAtWordBoundaryOrAnywhere
           maximumLineCount: 2
           elide: Text.ElideRight
       }

    CoverActionList {
        CoverAction {
            iconSource: "image://theme/icon-cover-search"
            onTriggered: {
                do {
                    pageStack.pop(null, PageStackAction.Immediate)
                } while(!checkPageStack("MainPage"))
                appWindow.activate()
                pageStack.currentPage.focusSearch()
            }
        }
    }

}
