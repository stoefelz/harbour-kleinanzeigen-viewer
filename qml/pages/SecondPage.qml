import QtQuick 2.2
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5


Page{
    allowedOrientations: Orientation.All
    //item id gets by FirstPage
    property string item_id: "2115482518"
    //item array consists of:
    //[[username, userinfo], [big_pics, .. , big_pics], [small_pics, .., small_pics], heading, price, zip, date, views, [[detaillistright, detaillistleft], .., [detaillistright, detaillistleft]], [checktags, .. , checktags], text, link]
    property var item_array: []

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

            setHandler('msg', function(return_msg) {
                console.log('python message ' + return_msg)
            })

            importModule('get_item_entry', function() {})

            //start first "search" when opening app
            get_item(item_id)

        }

        onError: {
            console.log('python error: ' + traceback);
        }

        onReceived: {
            console.log('python: ' + data);
        }

        function get_item(id) {
            call('get_item_entry.get_item', [id], function(return_value) {
                item_array = JSON.parse(return_value)
                console.log("answer from python script: " + item_array)
                //if empty load error page
                if(item_array == undefined || item_array.length == 0)
                    pageLoader.source = "Error_Page.qml"
                else
                    pageLoader.source = "SilicaListView_for_Item.qml"
            })
        }

    }
}
