
# sin sincronizar ni na de na

import threading, time

A1 = A2 = B1 = B2 = 1
AS = BS = 0

class CelulaA(threading.Thread):
    def run(self):
        start = time.time()
        while time.time() - start < 10:
            global AS
            AS = int((A1 + A2 + BS) >= 3)
            print 'A', AS
            time.sleep(0.3)

class CelulaB(threading.Thread):
    def run(self):
        start = time.time()
        while time.time() - start < 10:
            global BS
            BS = int((B1 + B2 + AS) >= 2)
            print 'B', BS
            time.sleep(0.3)

CelulaA().start()
CelulaB().start()
