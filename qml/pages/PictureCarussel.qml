import QtQuick 2.0
import Sailfish.Silica 1.0

FullscreenContentPage {
    property var big_pic_urls: []
    property int current_index: 0

    function fill_model() {
        for(var i = 0; i < big_pic_urls.length; ++i) {
            picture_urls.append({"picture_url": big_pic_urls[i]})
        }
    }

    SlideshowView {
        id: slideshow
        anchors.fill: parent
//        itemWidth: parent.width
//        itemHeight: slideshow.width
//        height: slideshow.width
//        clip: true
        model: ListModel {
            id: picture_urls
        }

        delegate: Image {
            //anchors.fill: parent
            width: parent.width
            height: parent.height
            source: picture_url
            fillMode: Image.PreserveAspectFit
//            MouseArea {
//                anchors.fill: parent
//                onClicked: {
//                    pageStack.pop()
//                }
//            }
        }

    }
    Component.onCompleted: {
        fill_model()
        slideshow.positionViewAtIndex(current_index - 1, slideshow.Beginning)

    }
}
