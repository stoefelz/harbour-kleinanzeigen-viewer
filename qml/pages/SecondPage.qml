import QtQuick 2.2
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5

Page {
    allowedOrientations: Orientation.All
    //item id gets by FirstPage
    property string item_id: "2312064628"
    property var item_object: ({})

    PageBusyIndicator {
        id: busy_indicator
        running: true
    }

    Loader {
        id: pageLoader
        anchors.fill: parent
        onLoaded: {
            busy_indicator.running = false
        }
    }

    Python {
        id: python

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('.'))

            setHandler('msg', function (return_msg) {
                console.log('python message ' + return_msg)
            })

            importModule('get_item', function () {})

            //start first "search" when opening app
            get_item(item_id)
        }

        onError: {
            console.log('python error: ' + traceback)
        }

        onReceived: {
            console.log('python: ' + data)
        }

        function get_item(id) {
            call('get_item.get_item', [id], function (return_value) {
                console.log(return_value)
                item_object = JSON.parse(return_value)
                console.log(item_object)
                console.log("answer from python script: " + item_object)
                //if empty load error page
                if (item_object == undefined || item_object.length == 0)
                    pageLoader.source = "Error_Page.qml"
                else
                    pageLoader.source = "SilicaListView_for_Item.qml"
            })
        }
    }
}
