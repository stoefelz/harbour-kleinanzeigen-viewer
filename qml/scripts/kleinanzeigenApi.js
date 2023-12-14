.pragma library
//TODO ein else bei anderm status für netzwerkmeldungen
function kleinanzeigenGetRequest(urlTail, name, key, callback)  {
    var websiteUrl = 'https://api.kleinanzeigen.de/api/' + urlTail
    //var websiteUrl = 'http://10.3.141.103/' + urlTail
console.log(websiteUrl)
    var request = new XMLHttpRequest()
    request.open('GET', websiteUrl, true, name, key)

    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {console.log(request.status)
            if (request.status && request.status === 200) {
                callback(JSON.parse(request.responseText))
            }
        }
    }
    request.send()
}


function getAppDetails(callback) {
    var xhttp = new XMLHttpRequest()
    xhttp.open('POST', 'https://www.stoefelz.com/backend/app_values.php', true)

    xhttp.onreadystatechange = function() {
        if(xhttp.readyState === XMLHttpRequest.DONE) {
            if(xhttp.status && xhttp.status === 200) {
                var jsonResponse = JSON.parse(xhttp.responseText)
                callback(jsonResponse)
            }
        }
    }
    xhttp.send()
}
