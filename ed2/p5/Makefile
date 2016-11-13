ejecutar: programa
	./a.out

programa: alfabeto cifrador prueba.cpp
	g++ -g prueba.cpp alfabeto.o cifrador.o

alfabeto: alfabeto.h alfabeto.cpp
	g++ -g -c alfabeto.cpp -o alfabeto.o

cifrador: cifrador.h cifrador.cpp alfabeto
	g++ -g -c cifrador.cpp -o cifrador.o
