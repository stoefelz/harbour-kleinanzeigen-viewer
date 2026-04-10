import QtQuick 2.6
import Sailfish.Silica 1.0

FullscreenContentPage {
    allowedOrientations: Orientation.All
    property var bigPicUrls
    property int currentIndex
    property string objectName: "PictureGalleryPage"

    function fillModel() {
        for (var i = 0; i < bigPicUrls.length; ++i) {
            pictureUrls.append({"pictureUrl": bigPicUrls[i]})
        }
    }

    SlideshowView {
        id: slideshow
        anchors.fill: parent
        model: ListModel {
            id: pictureUrls
        }

        delegate: Item {
            width: slideshow.width
            height: slideshow.height

            Flickable {
                id: flick
                anchors.fill: parent
                contentWidth: Math.max(flick.width, image.paintedWidth * image.scale)
                contentHeight: Math.max(flick.height, image.paintedHeight * image.scale)
                interactive: image.scale > 1.0
                clip: true

                PinchArea {
                    anchors.fill: parent
                    pinch.target: image
                    pinch.minimumScale: 1.0
                    pinch.maximumScale: 4.0

                    onPinchStarted: slideshow.interactive = false

                    onPinchFinished: {
                        if (image.scale <= 1.0) {
                           image.scale = 1.0
                            flick.contentX = 0
                            flick.contentY = 0
                            slideshow.interactive = true
                        }
                        flick.returnToBounds()
                    }

                    Image {
                        id: image
                        width: slideshow.width
                        height: slideshow.height
                        anchors.centerIn: parent
                        source: pictureUrl
                        fillMode: Image.PreserveAspectFit
                        scale: 1.0
                        transformOrigin: Item.Center
                        asynchronous: true

                        onScaleChanged: {
                            var newContentWidth = Math.max(flick.width, image.paintedWidth * scale)
                            var newContentHeight = Math.max(flick.height, image.paintedHeight * scale)
                            flick.contentX = (newContentWidth - flick.width) / 2
                            flick.contentY = (newContentHeight - flick.height) / 2
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onDoubleClicked: {
                            if (image.scale > 1.0) {
                                image.scale = 1.0
                                flick.contentX = 0
                                flick.contentY = 0
                                slideshow.interactive = true
                            }
                            else {
                                var zoomFactor = 2.0
                                image.scale = zoomFactor

                                var newContentWidth = Math.max(flick.width, image.paintedWidth * zoomFactor)
                                var newContentHeight = Math.max(flick.height, image.paintedHeight * zoomFactor)
                                flick.contentX = (newContentWidth - flick.width) / 2
                                flick.contentY = (newContentHeight - flick.height) / 2

                                slideshow.interactive = false
                            }
                        }
                    }
                }
            }
        }


    }

    Component.onCompleted: {
        fillModel()
        //-1 because otherwise image index with current shown at slideshow in details and slideshow in fullscreen not equal
        slideshow.positionViewAtIndex(currentIndex - 1, ListView.Beginning)
    }
}
