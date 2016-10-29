FLAGS=-g

practica2: practica2.c cola
	gcc $(FLAGS) practica2.c cola.o -o p2

cola: cola.c cola.h
	gcc $(FLAGS) -c cola.c -o cola.o

clean:	
	-rm *.o
