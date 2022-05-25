import QtQuick 2.2
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.5

Page {
    property string id: ""
    id: page
    property var search_result: []

    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.All

    TextField {
        id: textfield
        anchors.top: parent.top
    }

    Label {
        id: label
        text: "Ramonna"
        anchors.verticalCenter: parent.verticalCenter
    }

    Button {
        id: button
        text: "Click me not" + id
        anchors.bottom: parent.bottom

        onClicked: {

        }
    }



}
