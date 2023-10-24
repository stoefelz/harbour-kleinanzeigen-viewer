import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page {
    allowedOrientations: Orientation.All

    function getZipList(string) {
        var request = new XMLHttpRequest()
        request.open('GET', websiteUrl + '/s-ort-empfehlungen.json?query=' + string, true)
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status && request.status === 200) {
                    //Javascript Object from JSON
                    var zipList = JSON.parse(request.responseText)
                    //Names of Indexes, because these are needed for Kleinanzeigen Search
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
                enabled: zipResultList.count == 0 ? true: false
                text: qsTr("Search for your city")
                hintText: qsTr("There are no results")
            }
        }

        model: ListModel {
            id: zipResultList
         }

        delegate: ZipItemDelegate {}

    }
}
