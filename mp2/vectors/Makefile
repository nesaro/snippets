main: obtencion principal.c
	gcc -g compvect.o metodo1.o metodo2.o obtenciondatos.o principal.c -o prueba1 -lm

obtencion: compvect metodo1 metodo2 obtenciondatos.c obtenciondatos.h
	gcc -g -c obtenciondatos.c

compvect: compvect.h compvect.c
	gcc -g -c compvect.c -o compvect.o

metodo1: metodo1.h metodo1.c
	gcc -g -c metodo1.c 

metodo2: metodo2.h metodo2.c
	gcc -g -c metodo2.c


