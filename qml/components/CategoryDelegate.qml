import QtQuick 2.0
import Sailfish.Silica 1.0

BackgroundItem {


    Label  {
        x: Theme.horizontalPageMargin
        width: parent.width - (2 * Theme.horizontalPageMargin)
        anchors.verticalCenter: parent.verticalCenter
        text: categoryName


        elide: TruncationMode.Elide

    }
}
