# This Python file uses the following encoding: utf-8

# if __name__ == "__main__":
#     pass

import pyotherside

def hallo(string="default"):
    if string == "hi":
        pyotherside.send('jajaj', "nonono")
    else:
        pyotherside.send('jajaj', string)
    return "hullu"
