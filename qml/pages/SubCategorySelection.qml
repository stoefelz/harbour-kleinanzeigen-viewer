import QtQuick 2.2
import Sailfish.Silica 1.0
import "../components"

Page {
    allowedOrientations: Orientation.All

    //these two properties were sent by previous page
    property var subCategories
    property var superCategory

    SilicaListView {
        anchors.fill: parent
        header: Column {
            width: parent.width

            PageHeader {
                title: superCategory["name"]
            }

        }
        model: ListModel {
            id: categoryModel
        }

        delegate: CategoryDelegate {
            onClicked: {
                filterProperties.categoryName = categoryName
                filterProperties.categoryId = categoryId
                filterProperties.reloadSearch = true
                pageStack.pop()
            }
        }
    }

    Component.onCompleted: {
        subCategories = JSON.parse(subCategories)
        superCategory = JSON.parse(superCategory)
        categoryModel.append({"categoryName": "Alles von " + superCategory["name"],
                                "categoryId": superCategory["id"]
                            })
        for(var i = 0; i < subCategories.length; ++i) {
            categoryModel.append({"categoryName": subCategories[i]["sub_name"],
                                    "categoryId": subCategories[i]["sub_number"]
                                })
        }

    }
 }
