import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5
import "../components"

Page {

    //Set page_numer = 1 and reload_search = true after every change, because search must be fully loaded again
    function reloadSearch() {
        filterProperties.pageNumber = 0
        filterProperties.reloadSearch = true
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


            SectionHeader {
                text: qsTr("Sorting")
            }

            ComboBoxSelfMade {
                id: comboCity
                property string descriptionText: qsTr("City")
                property string categoryDetailsDescription: filterProperties.zipName
                                                            === "" ? qsTr("Germany") : filterProperties.zipName
                property string categoryHint: qsTr("Select city or zip code")
                property bool resetVisible: filterProperties.zipName !== ""
                onClicked:  pageStack.push(Qt.resolvedUrl("ZipSelection.qml"))
                function resetFunction() {
                    filterProperties.zipJSONCode = ""
                    filterProperties.zipName = ""
                    filterProperties.zipRadius = ""
                    comboRadius.currentItem = noRadius
                    reloadSearch()
                }
            }

            ComboBox {
                id: comboRadius
                width: parent.width
                label: qsTr("Radius")
                description: qsTr("Add search radius to your city")
                //TODO wont work
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
                currentIndex: filterProperties.sorting
                menu: ContextMenu {
                    Repeater {
                        model: possibleFilterValues.sortingValues
                        MenuItem {
                            //format text for user view
                            text: {
                                switch(modelData) {
                                case possibleFilterValues.sortingValues[0]: qsTr("latest"); break
                                case possibleFilterValues.sortingValues[1]: qsTr("cheapest"); break
                                case possibleFilterValues.sortingValues[2]: qsTr("nearest"); break
                                default: qsTr("Currently not supported")
                                }
                            }
                            visible: {
                                //sortingValues[3] is currently not supported
                                //sortingValue[2] is nearest -> should be only enabled, if location filter is selected
                                if (modelData === possibleFilterValues.sortingValues[3] || (modelData === possibleFilterValues.sortingValues[2] && filterProperties.zipJSONCode === "")) {
                                    false
                                }
                                else {
                                    true
                                }
                            }
                        }
                    }
                }
                onValueChanged: {
                    filterProperties.sorting = comboSorting.currentIndex
                    reloadSearch()
                }

                Connections {
                    target: comboCity
                    onCategoryDetailsDescriptionChanged: {
                        //set sorting to nearest
                        filterProperties.sorting = 2
                        comboSorting.currentIndex = 2
                    }
                }

            }

            SectionHeader {
                text: qsTr("Selection")
            }

            ComboBoxSelfMade {
                property string descriptionText: qsTr("Category")
                property string categoryDetailsDescription: filterProperties.categoryName
                                                            === "" ? qsTr("All categories") : filterProperties.categoryName
                property string categoryHint: qsTr("Select category")
                property bool resetVisible: filterProperties.categoryName !== ""
                onClicked:  pageStack.push(Qt.resolvedUrl("CategorySelection.qml"))
                function resetFunction() {
                    filterProperties.categoryName = ""
                    filterProperties.categoryId = ""
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
                text: qsTr("Shipping")
            }

            ComboBox {
                id: comboShippingCarrier
                width: parent.width
                label: qsTr("Shipping Carrier")
                description: qsTr("Select your shipping carrier")
                currentIndex: filterProperties.shippingCarrier
                menu: ContextMenu {
                    MenuItem {
                        id: allCarriers
                        text: qsTr("All Carriers")
                    }

                    Repeater {
                        model: possibleFilterValues.shippingCarrier
                        MenuItem {
                            //format text for user view
                            text: modelData === "HERMES" ? "Hermes" : modelData
                        }
                    }
                }
                onValueChanged: {
                    //index 0 is allCarriers
                    filterProperties.shippingCarrier = comboShippingCarrier.currentIndex
                    console.log(comboShippingCarrier.currentIndex)
                    reloadSearch()
                }
            }

            ComboBox {
                id: comboShipping
                width: parent.width
                label: qsTr("Shipping")
                description: qsTr("Shipping possible or Only pickup")
                currentItem: {
                    if (filterProperties.shipping === true) {
                        shipping
                    } else if (filterProperties.shipping === false) {
                        noShipping
                    } else {
                        shippingAndNoShipping
                    }
                }
                menu: ContextMenu {
                    MenuItem {
                        id: shippingAndNoShipping
                        text: qsTr("Shipping and Pickup")
                    }
                    MenuItem {
                        id: shipping
                        text: qsTr("Shipping possible")
                    }
                    MenuItem {
                        id: noShipping
                        text: qsTr("Only Pickup")
                    }
                }
                onValueChanged: {
                    if (comboShipping.currentItem == shipping) {
                        filterProperties.shipping = true
                    } else if (comboShipping.currentItem == noShipping) {
                        filterProperties.shipping = false
                    } else {
                        filterProperties.shipping = null
                    }
                    reloadSearch()
                }
            }

            TextSwitch {
                id: buyNowOnly
                text: qsTr("Buy now only")
                checked: filterProperties.buynowOnly
                onCheckedChanged: {
                    checked ? filterProperties.buynowOnly = true : filterProperties.buynowOnly = false
                }
            }


        }

        PullDownMenu {

            MenuItem {
                text: qsTr("Delete all filter")
                onClicked: {
                    filterProperties.pageNumber = 1
                    filterProperties.sorting = 0
                    comboSorting.currentIndex = 0
                    filterProperties.seller = ""
                    comboSeller.currentItem = privatAndCommercial
                    filterProperties.typ = ""
                    comboTyp.currentItem = offerAndRequest
                    filterProperties.minPrice = ""
                    filterProperties.maxPrice = ""
                    filterProperties.zipJSONCode = ""
                    filterProperties.zipName = ""
                    filterProperties.zipRadius = ""
                    comboRadius.currentItem = noRadius
                    filterProperties.categoryId = ""
                    filterProperties.categoryName = ""
                    filterProperties.shippingCarrier = 0
                    comboShippingCarrier.currentIndex = 0
                    filterProperties.shipping = null
                    comboShipping.currentIndex = 0
                    filterProperties.buynowOnly = false
                    buyNowOnly.checked = false
                    filterProperties.reloadSearch = true
                }
            }
        }

    VerticalScrollDecorator {}

    }



    Python {
        id: python

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('../scripts/'))

            setHandler('msg', function (returnMsg) {
                console.log('python message ' + returnMsg)
            })

            importModule('get_all_categories', function () {})

        }

        onError: {
            console.log('python error: ' + traceback)
        }

        onReceived: {
            console.log('python: ' + data)
        }


        function getAllCategories() {
            call('get_all_categories.get_all_categories', [],
                 function (returnValue) {
                     var resultObject = JSON.parse(returnValue)
                     for (var key in resultObject) {
                         if(resultObject.hasOwnProperty(key)) {
                             categoryModel.append({"categoryName": resultObject[key]["name"],
                                                      "subCategories": JSON.stringify(resultObject[key]["subs"]),
                                                      "superCategory": JSON.stringify({"name": resultObject[key]["name"], "id": key})
                                                  })
                         }
                     }

                 })
        }
    }

    Component.onCompleted: {
        python.getAllCategories()
    }

    //without it, focus stays on fields if clicked in
    onActiveFocusChanged: {
        minPriceField.focus = false
        maxPriceField.focus = false
    }
}
