ejecutar: programa
	./a.out

programa: pcomponente componentes pruebadoc.cpp
	g++ -g pruebadoc.cpp pcomponente.o componentes.o

componentes: componentes.h componentes.cpp
	g++ -g -c componentes.cpp -o componentes.o

pcomponente: pcomponente.h pcomponente.cpp
	g++ -g -c pcomponente.cpp -o pcomponente.o
