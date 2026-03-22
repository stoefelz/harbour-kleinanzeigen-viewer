import QtQuick 2.6
import Sailfish.Silica 1.0
import Nemo.Connectivity 1.0
import Nemo.Notifications 1.0
import QtFeedback 5.0
import "pages"
import "components"
import "models"

ApplicationWindow {
    id: appWindow
    readonly property string websiteUrl: "https://www.kleinanzeigen.de"
    property SearchField searchFieldProperty: null;
    property bool offline: false
    //to have access to all filter properties all time
    FilterProperties {
        id: filterProperties
    }

    ListModel {
        id: categoryModel
    }

    Notification {
        id: offlineNotification
        body: qsTr("App is offline")
        expireTimeout: 3000
    }

    ThemeEffect {
       id: longBuzz
       effect: ThemeEffect.PressStrong
   }

    initialPage: Component { Main{ } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: Orientation.All

    //to check online status
    ConnectionHelper {
        id: connectionHelper
        onOnlineChanged: {
            if(online) {
                offline = false
            }
       }

        onNetworkConnectivityUnavailable: {
            offline = true
            offlineNotification.publish()
            longBuzz.play()
        }
     }
}
