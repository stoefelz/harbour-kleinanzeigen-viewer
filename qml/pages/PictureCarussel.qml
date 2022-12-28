import QtQuick 2.0
import Sailfish.Silica 1.0

FullscreenContentPage {

    anchors.fill: parent
    property var big_pic_urls: []
    property int current_index: 0

    function fill_model() {
        for (var i = 0; i < big_pic_urls.length; ++i) {
            picture_urls.append({
                                    "picture_url": big_pic_urls[i]
                                })
        }
    }


    SlideshowView {
        id: slideshow
        anchors.fill: parent
        model: ListModel {
            id: picture_urls
        }

        delegate: Image {
            id: image
            width: parent.width
            height: parent.height
            source: picture_url
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
        fill_model()
        slideshow.positionViewAtIndex(current_index - 1, slideshow.Beginning)
    }
}
