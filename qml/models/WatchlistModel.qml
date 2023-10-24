import QtQuick 2.0
import Sailfish.Silica 1.0
import "../scripts/database.js" as DB

ListModel {
    id: watchlistModel

    function loadData() {
        watchlistModel.clear()
        var results = DB.getAllWatchlistItems()
        for (var i = 0; i < results.length; i++) {
            watchlistModel.append({
                        itemId: results[i].itemid,
                        heading: results[i].heading,
                        zip: results[i].zip,
                        price: results[i].price,
                        imageUrl: results[i].imageurl,
           })
        }
    }

    Component.onCompleted: loadData()

}
