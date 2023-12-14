import QtQuick 2.0

// Values for kleinanzeigen parser search_arguments
Item {
    property var sortingValues: ["DATE_DESCENDING", "PRICE_ASCENDING", "DISTANCE_ASCENDING", "RELEVANCE_DESCENDING"]
    property var sellerValues: {"commercialSeller": "COMMERCIAL", "privateSeller": "PRIVATE"}
    property var typeValues: {"offerType": "OFFERED", "wantedType": "WANTED"}
    property var zipRadiusValues: ["5", "10", "20", "30", "50", "100", "150", "200"]
    property var shippingCarrier: ["HERMES", "DHL"]
}
