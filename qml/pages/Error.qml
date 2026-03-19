import QtQuick 2.6
import Sailfish.Silica 1.0

SilicaFlickable {
    ViewPlaceholder {
        enabled: true
        text: qsTr("An error occurred")
        hintText: qsTr("Please wait and try again later")
    }
}
