import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    allowedOrientations: Orientation.All
    id: about_page

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
                id: page_header
                title: qsTr("About EK-Viewer")
            }

            Image {
                id: about_image
                width: Theme.itemSizeHuge
                height: Theme.itemSizeHuge
                anchors.horizontalCenter: parent.horizontalCenter
                source: "../cover/ek_viewer.svg" //"https://sailfishos.org/content/uploads/2021/02/SF4.svg"
            }

            Label {
                text: qsTr("Ebay Kleinanzeigen viewer. My first app for Sailfish OS.")
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

            Label {
                text: qsTr("© Pascal Stöfelz \n #nolife")
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: Theme.fontSizeSmall
            }

            Label {
                id: link_label
                text: qsTr("Ebay Kleinanzeigen Viewer")
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.underline: true

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("WebView.qml"), { "itemUrl": "https://github.com/stoefelz/ek_viewer"})
                    }
                }
            }

            SectionHeader {
                text: qsTr("Thanks")
            }

            Label {
                text: qsTr("This app uses EK Simple Parser (Thanks to myself)")
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap

            }

            Label {
                text: qsTr("EK Simple Parser")
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.underline: true

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        pageStack.push(Qt.resolvedUrl("WebView.qml"), { "itemUrl": "https://www.github.com/stoefelz/ek_simple_parser"})
                    }
                }
            }
        }
    }
}
