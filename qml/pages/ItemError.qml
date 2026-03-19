import QtQuick 2.6
import Sailfish.Silica 1.0

SilicaFlickable {
    ViewPlaceholder {
        enabled: true
        text: qsTr("Item cannot be shown")
        hintText: qsTr("Maybe this item does not exist anymore")
    }
}
