
# sin sincronizar ni na de na

import threading, time, weakref

class Celula(threading.Thread):

    def __init__(self, nombre, val):
        threading.Thread.__init__(self)
        self.entrada2 = 0
        self.entrada1 = 0
        self.salida = 0
        self.hermana = None
        self.nombre = nombre
        self.val = val

    def sethermana(self, h):
        self.hermana = weakref.ref(h)

    def run(self):
        start = time.time()
        while time.time() - start < 10:
            self.salida = int((self.entrada1 + self.entrada2 + self.hermana().salida) >= self.val)
            print self.nombre, self.entrada1, self.entrada2, self.hermana().salida, '->', self.salida

            time.sleep(0.3)

            self.entrada1 = self.sig()
            self.entrada2 = self.sig()

    def sig(self):
        import random
        return random.randint(0,1)

A = Celula('cell A', 3)
B = Celula('cell B', 2)

A.sethermana(B)
B.sethermana(A)

A.start()
B.start()
