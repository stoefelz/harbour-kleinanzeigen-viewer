import QtQuick 2.0
import "../scripts/kleinanzeigenApi.js" as API

Item {
    id: appDetails
    property string name
    property string key

    function loadData() {
        API.getAppDetails(function(response) {
            name = response['name']
            key = response['key']
        })
    }

    Component.onCompleted: loadData()
}
