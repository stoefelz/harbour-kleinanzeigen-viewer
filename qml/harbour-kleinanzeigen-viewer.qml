import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow {
    id: appWindow
    readonly property string websiteUrl: "https://www.kleinanzeigen.de"
    property SearchField searchFieldProperty: null;
    //to have access to all filter properties all time
    FilterProperties {
        id: filterProperties
    }

    initialPage: Component { StartPageWithSearchResults{ } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations
}
