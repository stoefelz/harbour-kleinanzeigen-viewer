import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {

    Image {
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        opacity: 0.4
        source: "https://sailfishos.org/content/uploads/2021/02/SF4.svg"
    }

    Label {
           anchors {
               horizontalCenter: parent.horizontalCenter
               top: parent.top
               topMargin: Theme.paddingLarge
           }
           color: Theme.highlightColor
           text: qsTr("EK Viewer")
       }

}
