import QtQuick 2.0
import Sailfish.Silica 1.0
import "../database.js" as DB

ListModel {
    id: favouriteModel

    function loadData() {
        favouriteModel.clear()
        var results = DB.getAllFavourites()
        for (var i = 0; i < results.length; i++) {
            favouriteModel.append({
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
