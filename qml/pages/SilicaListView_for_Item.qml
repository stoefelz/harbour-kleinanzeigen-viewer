import QtQuick 2.2
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5

SilicaFlickable {
    property int detail_list_length: item_array[8].length
    property int check_list_length: item_array[9].length

    function fill_models() {
        for(var i = 0; i < item_array[2].length; ++i) {
            picture_urls.append({"image_url": item_array[2][i]})

        }

        for(var i = 0; i < item_array[8].length; ++i) {
            detail_item_list.append({"detail_description": item_array[8][i][1], "detail_content": item_array[8][i][0]})
        }

        for(var i = 0; i < item_array[9].length; ++i) {
            check_list_model.append({"check_list_item": item_array[9][i]})
        }



    }
    //for loader qml -> requires following array with name "item_array"
    //[[username, userinfo], [big_pics, .. , big_pics], [small_pics, .., small_pics], heading, price, zip, date, views, [[detaillistright, detaillistleft], .., [detaillistright, detaillistleft]], [checktags, .. , checktags], text, link]
    //          0                       1                               2                3      4       5   6       7                                       8                                                           9         10    11

    //TODO datei umbenennen ist keine Silivaview sondern flickable
    anchors.fill: parent
    contentHeight: header.height + item_details.height + description.height + pic_carussel.height + section_header_description.height + section_header_details.height + detail_list.height + check_list.height + section_header_checklist.height + section_header_footer.height + linkbutton.height + userinfo.height + 3*Theme.paddingLarge



    //TODO immer checken ob arrayplatz leer, weil wenn, dann zeug net anzeigen
//TODO schauen ob nicht verfügbar mehr
    PageHeader {
        id: header
        anchors.top: parent.top
        title: qsTr("Viewer")
    }

    SlideshowView {
        id: pic_carussel
        height:  pic_carussel.width
        width: parent.width
        clip: true
        anchors {
            top: header.bottom
            right: parent.right; rightMargin: Theme.horizontalPageMargin
            left: parent.left; leftMargin: Theme.horizontalPageMargin

        }

        model: ListModel { id: picture_urls }

        delegate: Image {
            id: image_item
            source: image_url

            width: parent.width
            height: parent.height
            fillMode: Image.PreserveAspectFit

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("PictureCarussel.qml"), {big_pic_urls: item_array[1], current_index: pic_carussel.currentIndex})
                }
            }
        }
    }


    Rectangle {
        id: item_details
        height: heading.height + price.height + zip.height
        color: "transparent"

        anchors {
            top: pic_carussel.bottom; topMargin: Theme.paddingLarge
            left: parent.left; leftMargin: Theme.horizontalPageMargin
            right: parent.right; rightMargin: Theme.horizontalPageMargin
        }

        Label {
            id: heading
            width: parent.width
            text: item_array[3]
            font.pixelSize: Theme.fontSizeLarge
            color: Theme.highlightColor
            wrapMode: Text.WordWrap
        }

        Label {
            id: price
            text: item_array[4]
            anchors.top: heading.bottom
            anchors.right: parent.right
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeLarge
        }

        Label {
            id: views
            text: item_array[7] + " " + qsTr("Views")
            anchors.bottom: price.bottom
            anchors.left: parent.left
            anchors.topMargin: Theme.paddingSmall
            font.pixelSize: Theme.fontSizeSmall
        }

        Label {
            id: date
            text: item_array[6]
            anchors.bottom: price.bottom
            anchors.left: views.right
            anchors.topMargin: Theme.paddingSmall
            anchors.leftMargin: Theme.paddingMedium
            font.pixelSize: Theme.fontSizeSmall
        }

        Label {
            id: zip
            text: item_array[5]
            anchors.top: price.bottom
            anchors.left: parent.left
            font.pixelSize: Theme.fontSizeSmall
            width: parent.width
            wrapMode: Text.WordWrap
        }

    }

    SectionHeader {
        id: section_header_details
        text: qsTr("Details")
        anchors.top: item_details.bottom
    }

    SilicaListView {
        id: detail_list
        anchors.top: section_header_details.bottom
        width: parent.width
        height: Theme.itemSizeExtraSmall / 1.25 * detail_list_length

        model: ListModel { id: detail_item_list }

        delegate: DetailItem {
            id: detail_item
            height: Theme.itemSizeExtraSmall / 1.25
            //clip: true

            label: detail_description
            value: detail_content
        }
    }

    SectionHeader {
        id: section_header_checklist
        text: qsTr("Features")
        anchors.top: detail_list.bottom
    }

    SilicaGridView {
        id: check_list
        anchors.top: section_header_checklist.bottom
        width: parent.width
        height: check_list_length % 2.0  ?
                    (check_list.cellHeight * check_list_length / 2 + 1) : (check_list.cellHeight * check_list_length / 2)

        anchors {
            right: parent.right; //rightMargin: Theme.horizontalPageMargin
            left: parent.left; leftMargin: Theme.horizontalPageMargin
        }

        cellWidth: width/2
        cellHeight: Theme.itemSizeExtraSmall / 1.25

        model: ListModel {
            id: check_list_model
        }
        delegate: Item {
            id: item
            width: check_list.cellWidth //- Theme.horizontalPageMargin
            height: check_list.cellHeight
            clip: true


            Label {
                text: check_list_item
                width: parent.width
                anchors {
                    verticalCenter: parent.verticalCenter

                }

                font.pixelSize: Theme.fontSizeMedium
                truncationMode: TruncationMode.Fade
            }
        }



    }

    SectionHeader {
        id: section_header_description
        text: qsTr("Description")
        anchors.top: check_list.bottom
    }

    Rectangle {
        id: description
        height: text.height
        color: "transparent"

        anchors {
            top: section_header_description.bottom
            left: parent.left; leftMargin: Theme.horizontalPageMargin
            right: parent.right; rightMargin: Theme.horizontalPageMargin
        }


        Label {
            id: text
            width: parent.width
            text: item_array[10]
            wrapMode: Text.WordWrap
        }
    }


    SectionHeader {
        id: section_header_footer
        text: qsTr("Info")
        anchors.top: description.bottom
    }

    Label {
        id: userinfo
        text: item_array[0][0] + ": " + item_array[0][1]
        anchors {
            top: section_header_footer.bottom
            left: parent.left; leftMargin: Theme.horizontalPageMargin
            right: parent.right; rightMargin: Theme.horizontalPageMargin
        }
        width: parent.width
        truncationMode: TruncationMode.Fade
    }

    Button {
        id: linkbutton
        anchors {
            top: userinfo.bottom; topMargin: Theme.paddingLarge
            horizontalCenter: parent.horizontalCenter
        }


        text: qsTr("Link to Item")
        onClicked: {
            Qt.openUrlExternally(item_array[11]);
        }
    }


    PullDownMenu {

        MenuItem {
            text: qsTr("Link to Item")
        }
        MenuItem {
            text: qsTr("Reload")
        }

    }



    VerticalScrollDecorator {}

    Component.onCompleted: {
        fill_models();
    }

}
