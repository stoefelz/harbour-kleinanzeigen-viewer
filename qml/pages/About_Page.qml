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
            //anchors.fill: parent
            spacing: Theme.paddingLarge
            width: about_page.width


            PageHeader {
                id: page_header
                title: qsTr("About EK-Viewer")
            }

            Image {
                id: about_image
                width: Theme.itemSizeHuge
                height: Theme.itemSizeHuge
                anchors.horizontalCenter: parent.horizontalCenter
                source: "https://sailfishos.org/content/uploads/2021/02/SF4.svg"
            }

            Label {
                text: qsTr("Ebay Kleinanzeigen viewer. My first app for Sailfish OS.")
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - (2 * Theme.horizontalPageMargin)
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
                text: qsTr("<a href='https://ek-viewer.stoefelz.com'>ek-viewer.stoefelz.com</a>")
                anchors.horizontalCenter: parent.horizontalCenter


                font.pixelSize: Theme.fontSizeSmall
                linkColor: Theme.highlightColor
                onLinkActivated: Qt.openUrlExternally(link)

            }

            SectionHeader {
                text: qsTr("Thanks")
            }

            Label {
                text: qsTr("This app uses EK Simple Parser (Thanks to myself)")
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width - (2 * Theme.horizontalPageMargin)
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }



            Label {
                text: qsTr("<a href='https://www.github.com/stoefelz/ek-simple-parser'>EK Simple Parser</a>")
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: Theme.fontSizeSmall
                linkColor: Theme.highlightColor
                onLinkActivated: Qt.openUrlExternally(link)
            }




        }


    }

}
