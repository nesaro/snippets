class Cancion:
    def __init__(self,ruta):
        self.ruta = ruta

class GestorCanciones:
    def __init__(self):
        self.listaficheros = []

    def cargarruta(self, ruta):
        import os, re
        ficheros = os.listdir(ruta)
        testmp3 = re.compile(".*\.mp3$", re.IGNORECASE)
        listamp3 = filter(testmp3.search, ficheros)
        for mp3 in listamp3:
            self.listaficheros.append(Cancion(mp3))

    def playRandom(self):
        from random import choice
        import os
        import subprocess
        while 1:
            os.system("mplayer "+ str(choice(self.listaficheros).ruta))
            subprocess.Popen(["mplayer",str(choice(self.listaficheros).ruta)]).wait()


a = GestorCanciones()
a.cargarruta("/home/brbk/almacen/mus/")
a.playRandom()
        
