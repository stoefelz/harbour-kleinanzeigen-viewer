import QtQuick 2.0
import Sailfish.Silica 1.0

ListItem {

    BackgroundItem {
        property string id: jsonID

        Label  {
            x: Theme.horizontalPageMargin
            width: parent.width - (2 * Theme.horizontalPageMargin)
            anchors.verticalCenter: parent.verticalCenter
            text: cityName
            elide: TruncationMode.Elide
        }

        onClicked: {
            filterProperties.zipJSONCode = jsonID.substring(0, 1) === "_" ? jsonID.substring(1) : jsonID
            filterProperties.zipName = cityName
            filterProperties.reloadSearch = true
            pageStack.pop()
        }
    }
}
