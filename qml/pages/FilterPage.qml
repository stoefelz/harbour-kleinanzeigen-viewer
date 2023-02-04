import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
/**** Set page_numer = 1 and reload_search = true after every change, because search must be fully loaded again ***/
    //    property string sorting: ""
    //    property string seller: ""
    //    property string typ: ""
    //    property int min_price: 0
    //    property int max_price: 0

    allowedOrientations: Orientation.All
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: header_column.height

        Column {
            id: header_column
            width: parent.width

            PageHeader {
                id: header
                title: qsTr("Filters")
            }

            BackgroundItem {
                Column {
                    Row {
                        x: Theme.horizontalPageMargin
                        Label {

                            text: "Place "
                        }
                        Label {
                            color: Theme.highlightColor
                            text: "Germany"
                        }
                    }
                    Label {
                        x: Theme.horizontalPageMargin
                        color: Theme.secondaryColor
                        font.pixelSize: Theme.fontSizeExtraSmallBase
                        text: "jsonID"

                    }
                }
                onClicked:  pageStack.push(Qt.resolvedUrl("ZipSelection.qml"))
            }


            ComboBox {
                width: parent.width
                label: "Radius"

                menu: ContextMenu {
                    MenuItem { text: "Ganzer Ort" }
                    MenuItem { text: "+5km" }
                    MenuItem { text: "+10km" }
                    MenuItem { text: "+15km" }
                }
            }

            ComboBox {
                id: combo_sorting
                width: parent.width
                label: qsTr("Sorting")
                description: qsTr("Sorting of your search results")
                currentItem: sorting == "preis" ? cheapest : latest

                menu: ContextMenu {
                    MenuItem {
                        id: latest
                        text: qsTr("latest")
                    }
                    MenuItem {
                        id: cheapest
                        text: qsTr("cheapest")
                    }
                }
                onValueChanged: {
                    if (combo_sorting.currentItem == latest)
                        sorting = "neu"
                    else
                        sorting = "preis"
                    reload_search = true
                    page_number = 1
                }
            }

            ComboBox {
                id: combo_seller
                width: parent.width
                label: qsTr("Seller")
                description: qsTr("Private or commercial seller")
                currentItem: {
                    if (seller == "privat")
                        privat
                    else if (seller == "gewerblich")
                        commercial
                    else
                        privat_commercial
                }

                menu: ContextMenu {
                    MenuItem {
                        id: privat_commercial
                        text: qsTr("private and commercial")
                    }
                    MenuItem {
                        id: privat
                        text: qsTr("private")
                    }
                    MenuItem {
                        id: commercial
                        text: qsTr("commercial")
                    }
                }

                onValueChanged: {
                    if (combo_seller.currentItem == privat)
                        seller = "privat"
                    else if (combo_seller.currentItem == commercial)
                        seller = "gewerblich"
                    else
                        seller = ""
                    reload_search = true
                    page_number = 1
                }
            }

            ComboBox {
                id: combo_typ
                width: parent.width
                label: qsTr("Type")
                description: qsTr("Offer Type")
                currentItem: {
                    if (typ == "angebote")
                        offer
                    else if (typ == "gesuche")
                        request
                    else
                        offer_request
                }
                menu: ContextMenu {
                    MenuItem {
                        id: offer_request
                        text: qsTr("offer and request")
                    }
                    MenuItem {
                        id: offer
                        text: qsTr("offer")
                    }
                    MenuItem {
                        id: request
                        text: qsTr("request")
                    }
                }
                onValueChanged: {
                    if (combo_typ.currentItem == offer)
                        typ = "angebote"
                    else if (combo_typ.currentItem == request)
                        typ = "gesuche"
                    else
                        typ = ""
                    reload_search = true
                    page_number = 1
                }
            }

            SectionHeader {
                id: section_price
                text: qsTr("Price")
            }

            Rectangle {
                id: price_rect
                width: parent.width
                height: min_price_field.height
                color: "transparent"

                TextField {
                    id: min_price_field
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    placeholderText: qsTr("min")
                    label: qsTr("min")
                    rightItem: Label {
                        text: qsTr("€")
                    }
                    width: parent.width / 2
                    validator: IntValidator {
                        bottom: 0
                        top: 1000000
                    }
                    strictValidation: true
                    text: {
                        if (min_price > 0 && min_price < 1000000)
                            min_price
                        else
                            ""
                    }
                    EnterKey.onClicked: focus = false
                    onTextChanged: {
                        if(min_price_field.text == "") {
                            min_price = 0
                            console.log("HALLALSKDJFLKDSJFLKJF")
                            console.log(min_price)
                        }
                        else
                            min_price = min_price_field.text
                        reload_search = true
                        page_number = 1
                    }
                }

                TextField {
                    id: max_price_field
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    anchors.left: min_price_field.right
                    placeholderText: qsTr("max")
                    label: qsTr("max")
                    rightItem: Label {
                        text: qsTr("€")
                    }
                    width: parent.width / 2
                    validator: IntValidator {
                        bottom: 0
                        top: 1000000
                    }
                    strictValidation: true
                    text: {
                        if (max_price >= 0 && max_price < 1000000)
                            max_price
                        else
                            ""
                    }
                    EnterKey.onClicked: focus = false
                    onTextChanged: {
                        if(max_price_field.text == "")
                            max_price = 1000000
                        else
                            max_price = max_price_field.text
                        reload_search = true
                        page_number = 1
                    }
                }
            }
        }
    }
}
