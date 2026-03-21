import QtQuick 2.6
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5
import "../components"

Page {
    id: filterPage
    allowedOrientations: Orientation.All
    property bool wasLoaded: false
    //Set page_numer = 1 and reload_search = true after every change, because search must be fully loaded again
    function reloadProperties() {
        filterProperties.pageNumber = 1
        filterProperties.reloadSearch = true
    }

    PossibleFilterValues {
        id: possibleFilterValues
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: filterContent.height

        Column {
            id: filterContent
            width: parent.width

            PageHeader {
                title: qsTr("Filters")
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
                    reloadProperties()
                }

            }

            ComboBoxSelfMade {
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
                    reloadProperties()
                }
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

                onCurrentIndexChanged:  {
                    if (comboRadius.currentItem == noRadius) {
                        filterProperties.zipRadius = ""
                    } else {
                        //currentIndex -1 because noRadius takes index 0, but the Repeater list must start with index 0 again
                        filterProperties.zipRadius
                                = possibleFilterValues.zipRadiusValues[comboRadius.currentIndex - 1]
                    }
                    reloadProperties()
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

                onCurrentIndexChanged: {
                    if (comboSorting.currentItem == latest) {
                        filterProperties.sorting = possibleFilterValues.dateSorting
                    } else {
                        filterProperties.sorting = possibleFilterValues.priceSorting
                    }
                    reloadProperties()
                }
            }

            ComboBox {
                id: comboSeller
                width: parent.width
                label: qsTr("Seller")
                description: qsTr("Private or commercial seller")
                currentItem: {
                    if (filterProperties.seller
                            === possibleFilterValues.privateSeller) {
                        privat
                    } else if (filterProperties.seller
                               === possibleFilterValues.commercialSeller) {
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

                onCurrentIndexChanged: {
                    if (comboSeller.currentItem == privat) {
                        filterProperties.seller = possibleFilterValues.privateSeller
                    } else if (comboSeller.currentItem == commercial) {
                        filterProperties.seller = possibleFilterValues.commercialSeller
                    } else {
                        filterProperties.seller = ""
                    }
                    reloadProperties()
                }
            }

            ComboBox {
                id: comboTyp
                width: parent.width
                label: qsTr("Type")
                description: qsTr("Offer Type")
                currentItem: {
                    if (filterProperties.typ === possibleFilterValues.offerType) {
                        offer
                    } else if (filterProperties.typ === possibleFilterValues.wantedType) {
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
                onCurrentIndexChanged:  {
                    if (comboTyp.currentItem == offer) {
                        filterProperties.typ = possibleFilterValues.offerType
                    } else if (comboTyp.currentItem == request) {
                        filterProperties.typ = possibleFilterValues.wantedType
                    } else {
                        filterProperties.typ = ""
                    }
                    reloadProperties()
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
                        if (filterProperties.minPrice >= 0
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
                        reloadProperties()
                    }
                }

                TextField {
                    id: maxPriceField
                    inputMethodHints: Qt.ImhFormattedNumbersOnly
                    anchors.left: minPriceField.right
                    placeholderText: qsTr("max")
                    label: qsTr("max")
                    //behaviour was changed
                    /*description: {
                        if (maxPriceField.text.length === 0) {
                            ""
                        } else {
                            qsTr("When adding max price all free items will disappear in search results")
                        }
                    }*/
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
                        reloadProperties()
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
                    filterProperties.categoryId = ""
                    filterProperties.categoryName = ""
                    filterProperties.reloadSearch = true
                    comboRadius.currentItem = noRadius
                    comboSorting.currentItem = latest
                    comboSeller.currentItem = privatAndCommercial
                    comboTyp.currentItem = offerAndRequest
                }
            }
        }
    }

    Python {
        id: python

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('../kleinanzeigen_parser/'))

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
                     //for reloading function later when online
                     if(resultObject && resultObject.length > 0) {
                         wasLoaded = true
                     }
             })
        }
    }

    onStatusChanged: {
        if (!wasLoaded && !offline && status === PageStatus.Active) {
            python.getAllCategories()
        }
    }

    //without it, focus stays on fields if clicked in
    onActiveFocusChanged: {
        minPriceField.focus = false
        maxPriceField.focus = false
    }
}
