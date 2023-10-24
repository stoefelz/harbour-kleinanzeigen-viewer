import QtQuick 2.0
import Sailfish.Silica 1.0

Page {

    //Set page_numer = 1 and reload_search = true after every change, because search must be fully loaded again
    function reloadSearch() {
        filterProperties.pageNumber = 1
        filterProperties.reloadSearch = true
    }

    PossibleFilterValues {
        id: possibleFilterValues
    }

    allowedOrientations: Orientation.All
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: filterContent.height

        Column {
            id: filterContent
            width: parent.width

            PageHeader {
                title: qsTr("Filters")
            }

            BackgroundItem {
                Row {
                    width: parent.width

                    Column {
                        Row {
                            x: Theme.horizontalPageMargin
                            Label {
                                text: qsTr("City") + " "
                            }
                            Label {
                                color: Theme.highlightColor
                                text: filterProperties.zipName
                                      === "" ? qsTr("Germany") : filterProperties.zipName
                            }
                        }
                        Label {
                            x: Theme.horizontalPageMargin
                            color: Theme.secondaryColor
                            font.pixelSize: Theme.fontSizeExtraSmallBase
                            text: qsTr("Select city or zip code")
                        }
                    }
                }

                IconButton {
                    icon.source: "image://theme/icon-m-clear"
                    anchors.right: parent.right
                    visible: filterProperties.zipName !== ""
                    onClicked: {
                        filterProperties.zipJSONCode = ""
                        filterProperties.zipName = ""
                        filterProperties.zipRadius = ""
                        comboRadius.currentItem = noRadius
                        reloadSearch()
                    }
                }

                onClicked: pageStack.push(Qt.resolvedUrl("ZipSelection.qml"))
            }

            ComboBox {
                id: comboRadius
                width: parent.width
                label: qsTr("Radius")
                description: qsTr("Add search radius to your city")
                currentItem: filterProperties.zipRadius
                             === "" ? noRadius : filterProperties.zipRadius
                //should be only enabled when city is selected
                enabled: filterProperties.zipJSONCode === "" ? false : true

                menu: ContextMenu {
                    MenuItem {
                        id: noRadius
                        text: qsTr("Entire city")
                    }

                    Repeater {
                        model: possibleFilterValues.zipRadiusValues
                        MenuItem {
                            text: "+" + modelData + " km"
                        }
                    }
                }

                onValueChanged: {
                    if (comboRadius.currentItem == noRadius) {
                        filterProperties.zipRadius = ""
                    } else {
                        //currentIndex -1 because noRadius takes index 0, but the Repeater list must start with index 0 again
                        filterProperties.zipRadius
                                = possibleFilterValues.zipRadiusValues[comboRadius.currentIndex - 1]
                    }
                    reloadSearch()
                }
            }

            ComboBox {
                id: comboSorting
                width: parent.width
                label: qsTr("Sorting")
                description: qsTr("Sorting of your search results")
                currentItem: filterProperties.sorting === "preis" ? cheapest : latest

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
                    if (comboSorting.currentItem == latest) {
                        filterProperties.sorting = possibleFilterValues.sortingValues.dateSorting
                    } else {
                        filterProperties.sorting = possibleFilterValues.sortingValues.priceSorting
                    }
                    reloadSearch()
                }
            }

            ComboBox {
                id: comboSeller
                width: parent.width
                label: qsTr("Seller")
                description: qsTr("Private or commercial seller")
                currentItem: {
                    if (filterProperties.seller
                            === possibleFilterValues.sellerValues.privateSeller) {
                        privat
                    } else if (filterProperties.seller
                               === possibleFilterValues.sellerValues.commercialSeller) {
                        commercial
                    } else {
                        privatAndCommercial
                    }
                }

                menu: ContextMenu {
                    MenuItem {
                        id: privatAndCommercial
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
                    if (comboSeller.currentItem == privat) {
                        filterProperties.seller = possibleFilterValues.sellerValues.privateSeller
                    } else if (comboSeller.currentItem == commercial) {
                        filterProperties.seller = possibleFilterValues.sellerValues.commercialSeller
                    } else {
                        filterProperties.seller = ""
                    }
                    reloadSearch()
                }
            }

            ComboBox {
                id: comboTyp
                width: parent.width
                label: qsTr("Type")
                description: qsTr("Offer Type")
                currentItem: {
                    if (filterProperties.typ === possibleFilterValues.typeValues.offerType) {
                        offer
                    } else if (filterProperties.typ
                               === possibleFilterValues.typeValues.wantedType) {
                        request
                    } else {
                        offerAndRequest
                    }
                }
                menu: ContextMenu {
                    MenuItem {
                        id: offerAndRequest
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
                    if (comboTyp.currentItem == offer) {
                        filterProperties.typ = possibleFilterValues.typeValues.offerType
                    } else if (comboTyp.currentItem == request) {
                        filterProperties.typ = possibleFilterValues.typeValues.wantedType
                    } else {
                        filterProperties.typ = ""
                    }
                    reloadSearch()
                }
            }

            SectionHeader {
                text: qsTr("Price")
            }

            Rectangle {
                width: parent.width
                height: minPriceField.height
                color: "transparent"

                TextField {
                    id: minPriceField
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    placeholderText: qsTr("min")
                    label: qsTr("min")
                    rightItem: Label {
                        text: qsTr("€")
                    }
                    width: parent.width / 2
                    validator: IntValidator {
                        bottom: 0
                        top: 1000000000
                    }
                    strictValidation: true
                    text: {
                        if (filterProperties.minPrice > 0
                                && filterProperties.minPrice < 1000000000) {
                            filterProperties.minPrice
                        } else {
                            ""
                        }
                    }
                    EnterKey.onClicked: focus = false
                    onTextChanged: {
                        if (minPriceField.text === "") {
                            filterProperties.minPrice = ""
                        } else {
                            filterProperties.minPrice = minPriceField.text.toString()
                        }
                        reloadSearch()
                    }
                }

                TextField {
                    id: maxPriceField
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    anchors.left: minPriceField.right
                    placeholderText: qsTr("max")
                    label: qsTr("max")
                    description: {
                        if (maxPriceField.text.length === 0) {
                            ""
                        } else {
                            qsTr("When adding max price all free items will disappear in search results")
                        }
                    }
                    rightItem: Label {
                        text: qsTr("€")
                    }
                    width: parent.width / 2
                    validator: IntValidator {
                        bottom: 0
                        top: 1000000000
                    }
                    strictValidation: true
                    text: {
                        if (filterProperties.maxPrice >= 0
                                && filterProperties.maxPrice < 1000000000) {
                            filterProperties.maxPrice
                        } else {
                            ""
                        }
                    }
                    EnterKey.onClicked: focus = false
                    onTextChanged: {
                        if (maxPriceField.text === "") {
                            filterProperties.maxPrice = ""
                        } else {
                            filterProperties.maxPrice = maxPriceField.text.toString()
                        }
                        reloadSearch()
                    }
                }
            }
        }

        PullDownMenu {

            MenuItem {
                text: qsTr("Delete all filter")
                onClicked: {
                    filterProperties.pageNumber = 1
                    filterProperties.sorting = ""
                    filterProperties.seller = ""
                    filterProperties.typ = ""
                    filterProperties.minPrice = ""
                    filterProperties.maxPrice = ""
                    filterProperties.zipJSONCode = ""
                    filterProperties.zipName = ""
                    filterProperties.zipRadius = ""
                    filterProperties.reloadSearch = true
                    comboRadius.currentItem = noRadius
                    comboSorting.currentItem = latest
                    comboSeller.currentItem = privatAndCommercial
                    comboTyp.currentItem = offerAndRequest
                }
            }
        }
    }

    //without it, focus stays on fields if clicked in
    onActiveFocusChanged: {
        minPriceField.focus = false
        maxPriceField.focus = false
    }
}
