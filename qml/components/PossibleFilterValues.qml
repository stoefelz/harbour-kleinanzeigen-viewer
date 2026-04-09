import QtQuick 2.6

// Values for kleinanzeigen parser search_arguments
Item {
    readonly property string dateSorting: "SORTING_DATE"
    readonly property string priceSorting: "PRICE_AMOUNT"
    readonly property string commercialSeller: "COMMERCIAL"
    readonly property string privateSeller: "PRIVATE"
    readonly property string offerType: "OFFER"
    readonly property string wantedType: "WANTED"
    readonly property var zipRadiusValues: ["5", "10", "20", "30", "50", "100", "150", "200"]
}
