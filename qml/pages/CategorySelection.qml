import QtQuick 2.2
import Sailfish.Silica 1.0
import "../models"
import "../components"


Page {
    allowedOrientations: Orientation.All

    SilicaListView {
        anchors.fill: parent

        header: Column {
            width: parent.width

            PageHeader {
                title: qsTr("Categories")
            }

            PageBusyIndicator {
                id: busyIndicator
                running: categoryModel.count === 0 ? true : false
                visible: running ? true : false
            }
        }

        model: categoryModel

        delegate: CategoryDelegate {
            Icon {
                anchors.right: parent.right
                anchors.rightMargin: Theme.horizontalPageMargin
                 source: "image://theme/icon-m-right"
             }
            enabled: subCategories.length === 0 ? false : true

            onClicked: {
                pageStack.replace(Qt.resolvedUrl("SubCategorySelection.qml"), {"subCategories": subCategories, "superCategory": superCategory})
            }
        }




        VerticalScrollDecorator {}
    }


}
