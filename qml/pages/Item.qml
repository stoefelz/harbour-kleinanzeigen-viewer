import QtQuick 2.2
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5

Page {
    allowedOrientations: Orientation.All
    //item id gets by FirstPage
    property string itemId
    property var itemObject: ({})

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
        }

        onReceived: {
            console.log('python: ' + data)
        }

        function getItem(id) {
            call('get_item.get_item', [id], function (returnValue) {          
                itemObject = JSON.parse(returnValue)
                itemObject["item-id"] = itemId
                //if empty load error page
                if (itemObject === undefined || itemObject.length === 0) {
                    pageLoader.source = "Error.qml"
                }
                else {
                    pageLoader.source = "../components/ItemDetails.qml"
                }
            })
        }
    }
}
