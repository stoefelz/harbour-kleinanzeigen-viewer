import QtQuick 2.0

Item {
    property int pageNumber
    property int sorting
    property string seller
    property string typ
    property string minPrice
    property string maxPrice
    property string zipJSONCode
    property string zipName
    property string zipRadius
    property string categoryId
    property string categoryName
    property int shippingCarrier
    //true for only shipping, false for only pickup, null for both
    property var shipping: null
    property bool buynowOnly
    property bool reloadSearch    
}
