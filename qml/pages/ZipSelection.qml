import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: zipPage
    allowedOrientations: Orientation.All

    function getZipList(string) {

        var request = new XMLHttpRequest()
        request.open('GET', 'https://www.kleinanzeigen.de/s-ort-empfehlungen.json?query=' + string, true);
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status && request.status === 200) {
                    //Javascript Object from JSON
                    var zipList = JSON.parse(request.responseText)
                    //Names of Indexes, because these are needed for EbayK Search
                    var zipIndex = Object.getOwnPropertyNames(zipList)

                    //add to List
                    zipResultList.clear()
                    //counter is needed to access zipIndex
                    var counter = 0
                    for(var i in zipList) {
                        zipResultList.append({cityName: zipList [i], jsonID: zipIndex [counter]})
                        ++counter
                    }

                } else {
                    console.log("HTTP:", request.status, request.statusText)
                }
            }
        }

        request.send()
    }

    SilicaListView {
        //no keyboard focus change
        currentIndex: -1
        anchors.fill: parent

        header: Column {
            width: parent.width

            PageHeader {
                title: qsTr("Search for your city")
            }

            SearchField {
                width: parent.width
                focus: forceActiveFocus()
                placeholderText: qsTr("City or Zip")
                EnterKey.iconSource: "image://theme/icon-m-search"

                EnterKey.onClicked: this.focus = false
                onTextChanged: getZipList(this.text)
            }

            ViewPlaceholder {
                enabled: {
                    if (zipResultList.count == 0)
                        true
                    else
                        false
                }
                text: qsTr("Search for your city")
                hintText: qsTr("There are no results")
            }
        }

        model: ListModel {
            id: zipResultList
        }

        delegate: ListItem {

            BackgroundItem {
                property string id: jsonID

                Label  {
                    x: Theme.horizontalPageMargin
                    width: parent.width - (2*Theme.horizontalPageMargin)
                    anchors.verticalCenter: parent.verticalCenter
                    text: cityName
                    elide: TruncationMode.Elide
                }

                onClicked: {
                    pageStack.pop()
                }
            }
        }

    }
}
