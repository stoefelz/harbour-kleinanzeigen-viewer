.import QtQuick.LocalStorage 2.0 as LS

var initialized = false

function dbGetHandle() {
    try {
        var db = LS.LocalStorage.openDatabaseSync("kleinanzeigen-viewer", "1.0",
                                           "Kleinanzeigen DB", 100000)
        if(!initialized) {
            initDatabase(db)
            initialized = true
        }
        return db
    } catch(error) {
        console.log("Error opening database: " + error)
    }
}

function initDatabase(db) {
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS watchlist(itemid TEXT, heading TEXT, zip TEXT, price TEXT, imageurl TEXT, datetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL)')
        })

    } catch(error) {
        console.log("Error creating database " + error)
    }
}
//TODO check if double pasting
function storeWatchlistItem(itemId, heading, zip, price, imageUrl) {
    var db = dbGetHandle()
    db.transaction(function (tx) {
        var result = tx.executeSql('INSERT INTO watchlist (itemid, heading, zip, price, imageurl) VALUES (?, ?, ?, ?, ?)',
                                   [itemId, heading, zip, price, imageUrl])
    })
}

function existsWatchlistItem(itemId) {
    var db = dbGetHandle()
    var exist = false
    db.transaction(function (tx) {
        var result = tx.executeSql('SELECT * FROM watchlist WHERE itemid = ?', [itemId])
        result.rows.length > 0 ? exist = true : exist = false
    })
    return exist
}

function getAllWatchlistItems() {
    var db = dbGetHandle()
    var res = []
    db.transaction(function (tx) {
        var results = tx.executeSql('SELECT * FROM watchlist ORDER BY datetime DESC')
        for (var i = 0; i < results.rows.length; i++) {
            res.push(results.rows.item(i))
        }

    })
    return res
}

function deleteWatchlistItem(itemId) {
    var db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM watchlist WHERE itemid = ?', [itemId])
    })
}
