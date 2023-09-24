import QtQuick 2.0
import Sailfish.Silica 1.0
import Sailfish.WebView 1.0

Page {
    // itemUrl is handed over from previous page
    property string itemUrl: websiteUrl

    WebView {
        id: webView
        height: parent.height - webNavigation.height - loadingBar.height
        anchors.top: parent.top
        width: parent.width
        url: itemUrl
    }

    Row {
        id: webNavigation
        x: Theme.horizontalPageMargin
        anchors.top: loadingBar.bottom
        anchors.topMargin: Theme.paddingMedium
        width: parent.width - 2 * x
        height: (webView.canGoForward
                 || webView.canGoBack) ? forwardButton.height + 2 * Theme.paddingMedium : 0
        spacing: Theme.paddingLarge

        Button {
            id: backButton
            width: (parent.width - 2 * webNavigation.spacing) / 2
            text: qsTr("Back")
            enabled: webView.canGoBack ? true : false
            onClicked: {
                webView.goBack()
            }
        }

        Button {
            id: forwardButton
            text: qsTr("Forward")
            width: (parent.width - 2 * webNavigation.spacing) / 2
            enabled: webView.canGoForward ? true : false
            onClicked: {
                webView.goForward()
            }
        }
    }

    Rectangle {
        id: loadingBar
        height: Theme.paddingMedium / 1.5
        width: {
            if (webView.loading)
                parent.width / 110 * webView.loadProgress
            else
                parent.width
        }
        anchors.top: webView.bottom
        color: webView.loading ? Theme.highlightColor : "transparent"
    }
}
