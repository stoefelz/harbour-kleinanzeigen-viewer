import QtQuick 2.0

// Values for kleinanzeigen parser search_arguments
Item {
    property var sortingValues: {"dateSorting": "SORTING_DATE", "priceSorting": "PRICE_AMOUNT"}
    property var sellerValues: {"commercialSeller": "COMMERCIAL", "privateSeller": "PRIVATE"}
    property var typeValues: {"offerType": "OFFER", "wantedType": "WANTED"}
    property var zipRadiusValues: ["5", "10", "20", "30", "50", "100", "150", "200"]
}
