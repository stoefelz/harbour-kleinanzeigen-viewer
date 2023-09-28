import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    allowedOrientations: Orientation.All

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: aboutText.height
        anchors.bottomMargin: Theme.paddingLarge * 2

        Column {
            id: aboutText
            spacing: Theme.paddingLarge
            width: parent.width - Theme.horizontalPageMargin
            x: Theme.horizontalPageMargin

            PageHeader {
                title: qsTr("About Kleinanzeigen Viewer")
            }

            Image {
                width: Theme.itemSizeHuge
                height: Theme.itemSizeHuge
                anchors.horizontalCenter: parent.horizontalCenter
                source: "../cover/harbour-kleinanzeigen-viewer.png"
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
                    onClicked: pageStack.push(Qt.resolvedUrl("WebView.qml"), { "itemUrl": "https://github.com/stoefelz/kleinanzeigen_viewer"})
                }
            }

            SectionHeader {
                text: qsTr("Credits")
            }

            Label {
                text: qsTr("This app uses Beautiful Soup (Thanks to Leonard Richardson and his team) and Kleinanzeigen Parser (Thanks to myself)")
                width: parent.width
                wrapMode: Text.WordWrap

            }

            Label {
                text: qsTr("Kleinanzeigen Parser")
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.underline: true

                MouseArea {
                    anchors.fill: parent
                    onClicked: pageStack.push(Qt.resolvedUrl("WebView.qml"), { "itemUrl": "https://www.github.com/stoefelz/kleinanzeigen_parser"})
                }
            }

            Label {
                text: qsTr("Beautiful Soup")
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.underline: true

                MouseArea {
                    anchors.fill: parent
                    onClicked: pageStack.push(Qt.resolvedUrl("WebView.qml"), { "itemUrl": "https://www.crummy.com/software/BeautifulSoup/"})

                }
            }
        }
    }
}
