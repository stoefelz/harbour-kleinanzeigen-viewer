import QtQuick 2.6

// Values for kleinanzeigen parser search_arguments
Item {
    readonly property var sortingValues: {
        "dateSorting": "SORTING_DATE",
        "priceSorting": "PRICE_AMOUNT"
    }
    readonly property var sellerValues: {
        "commercialSeller": "COMMERCIAL",
        "privateSeller": "PRIVATE"
    }
    readonly property var typeValues: {
        "offerType": "OFFER",
        "wantedType": "WANTED"
    }
    readonly property var zipRadiusValues: ["5", "10", "20", "30", "50", "100", "150", "200"]
}
