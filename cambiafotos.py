import sys, Image, os

for f in sys.argv[1:]:
    ancho,alto = Image.open(f).size
    #if (ancho * 3 - alto * 4)
    #Si la proporcion es 4:3, Comprimir en horizontal 0.75
    
    #800x450
    coeficiente = 600.0/alto
    alto = 600
    ancho2 = float(ancho) * coeficiente
    ancho3 = float(ancho2) * 0.75
    print ancho,alto
    ancho4 = int(ancho3)
    cadena = "convert "+ " -extent "+ str(ancho)+ "x" + str(int(alto))+ " -resize " + str(ancho4) + "x" +  " " + str(f) + " /tmp/"+str(f)
    print cadena
    os.system(cadena)
#for i in *.jpg; do echo "$i"; convert "$i" -resize x50 "$i"; done
