import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"
import "components"
import "models"

ApplicationWindow {
    id: appWindow
    readonly property string websiteUrl: "https://www.kleinanzeigen.de"
    property SearchField searchFieldProperty: null;
    //to have access to all filter properties all time
    FilterProperties {
        id: filterProperties
    }

    ListModel {
        id: categoryModel
    }

    initialPage: Component { Main{ } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations
}
