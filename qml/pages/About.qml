import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    allowedOrientations: Orientation.All

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height
        anchors.bottomMargin: Theme.paddingLarge * 2

        Column {
            id: column
            spacing: Theme.paddingLarge
            width: parent.width - 2 * Theme.horizontalPageMargin
            x: Theme.horizontalPageMargin

            PageHeader {
                title: qsTr("About Kleinanzeigen Viewer")
            }

            Image {
                width: Theme.itemSizeHuge
                height: Theme.itemSizeHuge
                anchors.horizontalCenter: parent.horizontalCenter
                source: "../cover/ek_viewer.svg" //"https://sailfishos.org/content/uploads/2021/02/SF4.svg"
            }

            Label {
                text: qsTr("Kleinanzeigen Viewer. My first app for Sailfish OS.")
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

            Label {
                text: qsTr("© Pascal Stöfelz")
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Theme.fontSizeSmall
            }

            Label {
                text: qsTr("Kleinanzeigen Viewer")
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.underline: true

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("WebView.qml"), { "itemUrl": "https://github.com/stoefelz/kleinanzeigen_viewer"})
                    }
                }
            }

            SectionHeader {
                text: qsTr("Thanks")
            }

            Label {
                text: qsTr("This app uses Kleinanzeigen Parser (Thanks to myself)")
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap

            }

            Label {
                text: qsTr("Kleinanzeigen Parser")
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.underline: true

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("WebView.qml"), { "itemUrl": "https://www.github.com/stoefelz/kleinanzeigen_parser"})
                    }
                }
            }
        }
    }
}
