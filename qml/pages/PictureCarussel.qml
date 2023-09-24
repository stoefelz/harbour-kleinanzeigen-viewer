import QtQuick 2.0
import Sailfish.Silica 1.0

FullscreenContentPage {

    anchors.fill: parent
    property var bigPicUrls: []
    property int currentIndex: 0

    function fillModel() {
        for (var i = 0; i < bigPicUrls.length; ++i) {
            pictureUrls.append({
                                    "pictureUrl": bigPicUrls[i]
                                })
        }
    }

    SlideshowView {
        id: slideshow
        anchors.fill: parent
        model: ListModel {
            id: pictureUrls
        }

        delegate: Image {
            id: image
            width: parent.width
            height: parent.height
            source: pictureUrl
            fillMode: Image.PreserveAspectFit

            PinchArea {
                        anchors.fill: parent
                        enabled: image.status === Image.Ready
                        pinch.target: image
                        pinch.minimumScale: 1.0
                        pinch.maximumScale: 4.0

                        MouseArea {
                            anchors.fill: parent
                            onDoubleClicked: {
                                if(image.scale > 1.0)
                                    image.scale = 1.0
                                else
                                    image.scale = 2.0
                            }
                        }
                    }

            onXChanged:  image.scale = 1.0

        }
    }

    Component.onCompleted: {
        fillModel()
        slideshow.positionViewAtIndex(currentIndex - 1, slideshow.Beginning)
    }
}
