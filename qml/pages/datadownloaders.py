# This Python file uses the following encoding: utf-8

# if __name__ == "__main__":
#     pass
import pyotherside
import threading
import time
import random

colors = ['red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet']

def slow_function():
    for i in range(11):
        pyotherside.send('progress', i/10.0)
        time.sleep(0.5)
    pyotherside.send('u', random.choice(colors))

class Downloader:
    def __init__(self):
        # Set bgthread to a finished thread so we never
        # have to check if it is None.
        self.bgthread = threading.Thread()
        self.bgthread.start()

    def download(self):
        if self.bgthread.is_alive():
            return
        self.bgthread = threading.Thread(target=slow_function)
        self.bgthread.start()


downloader = Downloader()
