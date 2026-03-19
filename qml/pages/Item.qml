import QtQuick 2.6
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5

Page {
    allowedOrientations: Orientation.All
    //item id gets by FirstPage
    property string itemId
    property var itemObject: null

    PageBusyIndicator {
        id: busyIndicator
        running: true
    }

    Loader {
        id: pageLoader
        anchors.fill: parent
        onLoaded: {
            busyIndicator.running = false
        }
    }

    Python {
        id: python

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('../kleinanzeigen_parser/'))

            setHandler('msg', function (returnMsg) {
                console.log('python message ' + returnMsg)
            })

            importModule('get_item', function () {})

            //start first "search" when opening app
            getItem(itemId)
        }

        onError: {
            console.log('python error: ' + traceback)
            pageLoader.source = "ItemError.qml"
            busyIndicator.running = false
        }

        onReceived: {
            console.log('python: ' + data)
        }

        function getItem(id) {
            call('get_item.get_item', [id], function (returnValue) {
                if (!returnValue || returnValue === "" || returnValue === "null" || returnValue === "{}") {
                    console.log("ERROR: Empty or invalid response from Python")
                    pageLoader.source = "ItemError.qml"
                    return
                }

                try {
                    itemObject = JSON.parse(returnValue)
                } catch (error) {
                    console.log("ERROR: Failed to parse JSON:", error)
                    pageLoader.source = "ItemError.qml"
                    return
                }

                //if empty load error page
                if (!itemObject || itemObject == undefined || itemObject.length === 0) {
                    pageLoader.source = "ItemError.qml"
                }
                else {
                    itemObject["item-id"] = itemId
                    console.log(itemObject["item-id"])
                    pageLoader.source = "../components/ItemDetails.qml"
                }
            })
        }
    }
}
