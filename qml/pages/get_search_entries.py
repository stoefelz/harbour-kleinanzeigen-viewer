import requests
import json
from bs4 import BeautifulSoup
#import pyotherside

# returns the value of the first index in list, if not empty
def check_if_empty_return(string_list):
    if len(string_list) != 0:
        return string_list[0].text.lstrip()
    else:
        return ""


def get_search_entries(search_term, site = 1, sorting = "neu"):
    # list for return
    list_with_data = []

    #pyotherside.send('msg', search_term + " " + site)

    category = "/k0"

    if search_term == "":
        url = "https://www.ebay-kleinanzeigen.de/s-suchen.html"
    else:
        url = "https://www.ebay-kleinanzeigen.de/s/sortierung:" + sorting + "/seite:" + str(site) + "/" + search_term + category

    default_image_url = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1NiIgaGVpZ2h0PSI1OCIgdmlld0JveD0iMCAwIDU2IDU4IiBmaWxsPSJub25lIj4KICA8cGF0aCBmaWxsLXJ1bGU9ImV2ZW5vZGQiIGNsaXAtcnVsZT0iZXZlbm9kZCIgZD0iTTExLjY3IDguMzNDMTAuNTYgOC4zMyA5LjY3IDkuMjMgOS42NyAxMC4zM1YzM0M5LjY3IDM0LjEgMTAuNTYgMzUgMTEuNjcgMzVINDQuMzNDNDUuNDQgMzUgNDYuMzMgMzQuMSA0Ni4zMyAzM1YxMC4zM0M0Ni4zMyA5LjIzIDQ1LjQ0IDguMzMgNDQuMzMgOC4zM0gzNi4zM0wzNC4xMyA1LjRDMzMuOTQgNS4xNSAzMy42NSA1IDMzLjMzIDVIMjIuNjdDMjIuMzUgNSAyMi4wNiA1LjE1IDIxLjg3IDUuNEwxOS42NyA4LjMzSDExLjY3Wk0zOCAyMS42N0MzOCAyNy4xOSAzMy41MiAzMS42NyAyOCAzMS42NyAyMi40OCAzMS42NyAxOCAyNy4xOSAxOCAyMS42NyAxOCAxNi4xNCAyMi40OCAxMS42NyAyOCAxMS42NyAzMy41MiAxMS42NyAzOCAxNi4xNCAzOCAyMS42N1pNMzUuNSAyMS42N0MzNS41IDI1LjgxIDMyLjE0IDI5LjE3IDI4IDI5LjE3IDIzLjg2IDI5LjE3IDIwLjUgMjUuODEgMjAuNSAyMS42NyAyMC41IDE3LjUyIDIzLjg2IDE0LjE3IDI4IDE0LjE3IDMyLjE0IDE0LjE3IDM1LjUgMTcuNTIgMzUuNSAyMS42N1oiIGZpbGw9IiNCREJEQkQiLz4KICA8cGF0aCBkPSJNMC4wNiA0N0gxLjgxVjUxLjU1TDYuMjcgNDdIOC40Mkw0LjQzIDUwLjk5IDguNyA1N0g2LjUyTDMuMjQgNTIuMjMgMS44MSA1My42NFY1N0gwLjA2VjQ3Wk0xNC4zOSA1Mi43NEMxNC4zOCA1Mi40OSAxNC4zMiA1Mi4yNSAxNC4yMyA1Mi4wMiAxNC4xNCA1MS43OCAxNC4wMiA1MS41OCAxMy44NiA1MS40MSAxMy43MSA1MS4yNCAxMy41MyA1MS4xIDEzLjMgNTAuOTkgMTMuMDkgNTAuODggMTIuODQgNTAuODMgMTIuNTcgNTAuODMgMTIuMjkgNTAuODMgMTIuMDQgNTAuODggMTEuOCA1MC45OCAxMS41OCA1MS4wNyAxMS4zOCA1MS4yMSAxMS4yMiA1MS4zOSAxMS4wNiA1MS41NSAxMC45MyA1MS43NSAxMC44MiA1MS45OSAxMC43MyA1Mi4yMiAxMC42OCA1Mi40NyAxMC42NyA1Mi43NEgxNC4zOVpNMTAuNjcgNTMuNzlDMTAuNjcgNTQuMDcgMTAuNzEgNTQuMzQgMTAuNzggNTQuNjEgMTAuODcgNTQuODcgMTAuOTkgNTUuMSAxMS4xNSA1NS4yOSAxMS4zIDU1LjQ5IDExLjUxIDU1LjY1IDExLjc1IDU1Ljc3IDExLjk5IDU1Ljg4IDEyLjI4IDU1Ljk0IDEyLjYyIDU1Ljk0IDEzLjA4IDU1Ljk0IDEzLjQ2IDU1Ljg0IDEzLjc0IDU1LjY0IDE0LjAzIDU1LjQ0IDE0LjI0IDU1LjEzIDE0LjM4IDU0LjczSDE1Ljg5QzE1LjgxIDU1LjEyIDE1LjY2IDU1LjQ3IDE1LjQ2IDU1Ljc4IDE1LjI1IDU2LjA5IDE1LjAxIDU2LjM1IDE0LjcyIDU2LjU3IDE0LjQzIDU2Ljc3IDE0LjEgNTYuOTMgMTMuNzQgNTcuMDMgMTMuMzggNTcuMTQgMTMuMDEgNTcuMiAxMi42MiA1Ny4yIDEyLjA1IDU3LjIgMTEuNTQgNTcuMSAxMS4xIDU2LjkyIDEwLjY3IDU2LjczIDEwLjI5IDU2LjQ3IDkuOTggNTYuMTMgOS42OSA1NS44IDkuNDYgNTUuMzkgOS4zIDU0LjkzIDkuMTUgNTQuNDYgOS4wNyA1My45NSA5LjA3IDUzLjM5IDkuMDcgNTIuODcgOS4xNSA1Mi4zOSA5LjMxIDUxLjkzIDkuNDggNTEuNDcgOS43MSA1MS4wNiAxMC4wMSA1MC43MSAxMC4zMiA1MC4zNiAxMC42OSA1MC4wOCAxMS4xMiA0OS44NyAxMS41NSA0OS42NyAxMi4wMyA0OS41NyAxMi41NyA0OS41NyAxMy4xNCA0OS41NyAxMy42NSA0OS42OSAxNC4xIDQ5LjkzIDE0LjU2IDUwLjE2IDE0Ljk0IDUwLjQ4IDE1LjIzIDUwLjg3IDE1LjUzIDUxLjI2IDE1Ljc1IDUxLjcxIDE1Ljg4IDUyLjIzIDE2LjAyIDUyLjczIDE2LjA2IDUzLjI1IDE1Ljk5IDUzLjc5SDEwLjY3Wk0xNy4yNSA0N0gxOC44NFY0OC41MkgxNy4yNVY0N1pNMTcuMjUgNDkuNzZIMTguODRWNTdIMTcuMjVWNDkuNzZaTTIwLjU4IDQ5Ljc2SDIyLjA5VjUwLjgzTDIyLjEyIDUwLjg1QzIyLjM2IDUwLjQ1IDIyLjY4IDUwLjE0IDIzLjA3IDQ5LjkyIDIzLjQ2IDQ5LjY4IDIzLjkgNDkuNTcgMjQuMzcgNDkuNTcgMjUuMTcgNDkuNTcgMjUuNzkgNDkuNzcgMjYuMjUgNTAuMTggMjYuNzEgNTAuNTkgMjYuOTQgNTEuMjEgMjYuOTQgNTIuMDNWNTdIMjUuMzRWNTIuNDVDMjUuMzIgNTEuODggMjUuMiA1MS40NyAyNC45OCA1MS4yMiAyNC43NSA1MC45NiAyNC40IDUwLjgzIDIzLjkzIDUwLjgzIDIzLjY2IDUwLjgzIDIzLjQxIDUwLjg4IDIzLjIgNTAuOTggMjIuOTggNTEuMDcgMjIuOCA1MS4yMSAyMi42NSA1MS4zOSAyMi41IDUxLjU1IDIyLjM5IDUxLjc1IDIyLjMgNTEuOTkgMjIuMjIgNTIuMjIgMjIuMTggNTIuNDcgMjIuMTggNTIuNzNWNTdIMjAuNThWNDkuNzZaTTM0LjQ5IDUxLjE5SDM3LjM1QzM3Ljc3IDUxLjE5IDM4LjEyIDUxLjA3IDM4LjQgNTAuODQgMzguNjggNTAuNiAzOC44MiA1MC4yNSAzOC44MiA0OS44IDM4LjgyIDQ5LjMgMzguNjkgNDguOTUgMzguNDQgNDguNzQgMzguMTkgNDguNTMgMzcuODIgNDguNDMgMzcuMzUgNDguNDNIMzQuNDlWNTEuMTlaTTMyLjc0IDQ3SDM3LjZDMzguNDkgNDcgMzkuMjEgNDcuMjEgMzkuNzUgNDcuNjIgNDAuMyA0OC4wMyA0MC41NyA0OC42NSA0MC41NyA0OS40OCA0MC41NyA0OS45OSA0MC40NCA1MC40MiA0MC4xOSA1MC43OCAzOS45NSA1MS4xNCAzOS42IDUxLjQxIDM5LjE0IDUxLjYxVjUxLjY0QzM5Ljc1IDUxLjc3IDQwLjIyIDUyLjA2IDQwLjU0IDUyLjUyIDQwLjg2IDUyLjk3IDQxLjAxIDUzLjUzIDQxLjAxIDU0LjIxIDQxLjAxIDU0LjYxIDQwLjk0IDU0Ljk3IDQwLjggNTUuMzIgNDAuNjYgNTUuNjYgNDAuNDQgNTUuOTUgNDAuMTUgNTYuMiAzOS44NSA1Ni40NCAzOS40NiA1Ni42NCAzOSA1Ni43OSAzOC41MyA1Ni45MyAzNy45OCA1NyAzNy4zMyA1N0gzMi43NFY0N1pNMzQuNDkgNTUuNTdIMzcuNThDMzguMTIgNTUuNTcgMzguNTMgNTUuNDQgMzguODIgNTUuMTcgMzkuMTEgNTQuODkgMzkuMjYgNTQuNDkgMzkuMjYgNTMuOTkgMzkuMjYgNTMuNSAzOS4xMSA1My4xMiAzOC44MiA1Mi44NiAzOC41MyA1Mi41OSAzOC4xMiA1Mi40NSAzNy41OCA1Mi40NUgzNC40OVY1NS41N1pNNDIuNDIgNDdINDQuMDFWNDguNTJINDIuNDJWNDdaTTQyLjQyIDQ5Ljc2SDQ0LjAxVjU3SDQyLjQyVjQ5Ljc2Wk00NS43OSA0N0g0Ny4zOVY1N0g0NS43OVY0N1pNNTUuOTUgNTdINTQuNDNWNTYuMDJINTQuNDFDNTQuMTkgNTYuNDQgNTMuODggNTYuNzQgNTMuNDcgNTYuOTMgNTMuMDYgNTcuMTEgNTIuNjIgNTcuMiA1Mi4xNyA1Ny4yIDUxLjYgNTcuMiA1MS4xIDU3LjEgNTAuNjcgNTYuOSA1MC4yNSA1Ni43IDQ5LjkgNTYuNDIgNDkuNjIgNTYuMDggNDkuMzQgNTUuNzMgNDkuMTMgNTUuMzIgNDguOTkgNTQuODYgNDguODUgNTQuMzggNDguNzggNTMuODcgNDguNzggNTMuMzMgNDguNzggNTIuNjggNDguODcgNTIuMTEgNDkuMDQgNTEuNjQgNDkuMjIgNTEuMTYgNDkuNDUgNTAuNzcgNDkuNzQgNTAuNDYgNTAuMDQgNTAuMTUgNTAuMzggNDkuOTMgNTAuNzUgNDkuNzkgNTEuMTMgNDkuNjQgNTEuNTIgNDkuNTcgNTEuOTEgNDkuNTcgNTIuMTQgNDkuNTcgNTIuMzcgNDkuNTkgNTIuNiA0OS42NCA1Mi44MyA0OS42NyA1My4wNiA0OS43NCA1My4yNyA0OS44MyA1My40OSA0OS45MyA1My42OCA1MC4wNSA1My44NiA1MC4yIDU0LjA1IDUwLjM0IDU0LjIgNTAuNSA1NC4zMiA1MC43SDU0LjM1VjQ3SDU1Ljk1VjU3Wk01MC4zNyA1My40NkM1MC4zNyA1My43NyA1MC40MSA1NC4wNyA1MC40OSA1NC4zNyA1MC41NyA1NC42NyA1MC42OSA1NC45MyA1MC44NSA1NS4xNyA1MS4wMiA1NS40IDUxLjIzIDU1LjU5IDUxLjQ4IDU1LjczIDUxLjczIDU1Ljg3IDUyLjAzIDU1Ljk0IDUyLjM4IDU1Ljk0IDUyLjczIDU1Ljk0IDUzLjAzIDU1Ljg2IDUzLjI5IDU1LjcxIDUzLjU1IDU1LjU2IDUzLjc2IDU1LjM3IDUzLjkyIDU1LjEyIDU0LjA4IDU0Ljg4IDU0LjIgNTQuNjEgNTQuMjggNTQuMzEgNTQuMzYgNTQgNTQuNDEgNTMuNjkgNTQuNDEgNTMuMzcgNTQuNDEgNTIuNTcgNTQuMjIgNTEuOTUgNTMuODYgNTEuNSA1My41IDUxLjA1IDUzLjAyIDUwLjgzIDUyLjQgNTAuODMgNTIuMDMgNTAuODMgNTEuNzEgNTAuOTEgNTEuNDUgNTEuMDYgNTEuMiA1MS4yMSA1MC45OSA1MS40MSA1MC44MiA1MS42NyA1MC42NiA1MS45MSA1MC41NSA1Mi4xOSA1MC40NyA1Mi41MSA1MC40MSA1Mi44MSA1MC4zNyA1My4xMyA1MC4zNyA1My40NloiIGZpbGw9IiNBNkE2QTYiLz4KPC9zdmc+Cg=="


        #without headers ebay-kleinanzeigen blocks request TODO uncomment
    #headers = { 'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64; rv:100.0) Gecko/20100101 Firefox/100.0' }
    #html_site = requests.get(url, headers=headers)
    #TODO lxml on sailfish not ready
    #soup = BeautifulSoup(html_site.text, "html.parser")


        #TODO only for testing
    with open("suche.html") as fp:
        soup = BeautifulSoup(fp, "lxml",)



        # in every article tag is one complete search entry
    articles = soup.find_all('article')

    for one_article in articles:
        # for one search result
        article_list = []

        # get id from attribute
        element_id = one_article['data-adid']
        article_list.append(element_id)

        #get values from parsing correct class
        heading = one_article.find_all("a", class_="ellipsis")
        article_list.append(check_if_empty_return(heading))

        text = one_article.find_all("p", class_="aditem-main--middle--description")
        article_list.append(check_if_empty_return(text))

        price = one_article.find_all("p", class_="aditem-main--middle--price")
        article_list.append(check_if_empty_return(price))

        zip_code = one_article.find_all("div", class_="aditem-main--top--left")
        article_list.append(check_if_empty_return(zip_code))

        create_date = one_article.find_all("div", class_="aditem-main--top--right")
        article_list.append(check_if_empty_return(create_date))

        #get picture url from class, but must check if there is a picture or not
        picture = one_article.find_all("div", class_="imagebox")
        if len(picture) != 0:

            classes = picture[0]['class']
            #classes returns string list of the class names
            #searching for "is-nopic" then there is no image
            checker = True

            for one_class_name in classes:
                if one_class_name == "is-nopic":
                    article_list.append(default_image_url)
                    checker = False
                    break

            if checker == True:
                article_list.append(picture[0]['data-imgsrc'])

        else:
            article_list.append(default_image_url)

        #append it to the list for return
        list_with_data.append(article_list)

    #return list in json format
    return json.dumps(list_with_data)


