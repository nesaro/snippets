FLAGS=-g

practica3: practica3.c foro
	gcc $(FLAGS) practica3.c foro.o -o p3

foro: foro.c foro.h
	gcc $(FLAGS) -c foro.c -o foro.o

clean:	
	-rm *.o
