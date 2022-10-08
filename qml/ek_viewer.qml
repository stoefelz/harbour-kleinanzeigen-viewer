import QtQuick 2.0
import Sailfish.Silica 1.0

import "pages"

ApplicationWindow {
    property string sorting: ""
    property string seller: ""
    property string typ: ""
    property int min_price: 0
    property int max_price: 1000000
    property bool reload_search: false
    property SearchField search_field_property: null;

    initialPage: Component { FirstPage{ } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations
}
