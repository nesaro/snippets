#include "contenedor.h"
#include "assert.h"
#include <iostream>
using namespace std;
int main()
{
	//Pruebas de contenedores vacios
	Contenedor<int> c1,c2;
	int vector[10];
	assert(!c1.busca(0));
	assert(!c1.busca(10));
	assert(c1.tamano()==0);
	assert(c1.lista(vector,10)==0);
	c1=c2;
	c1=c1; //Copia a si mismo
	assert(!c1.busca(0));
	assert(!c1.busca(10));
	assert(c1.tamano()==0);
	assert(c1.lista(vector,10)==0);

	//Prueba de contenedores con un elemento
	c1.inserta(8);
	assert(c1.busca(8));
	assert(!c1.busca(10));
	assert(c1.tamano()==1);
	assert(c1.lista(vector,10)==1);
	c1=c1;
	assert(c1.busca(8));
	assert(!c1.busca(10));
	assert(c1.tamano()==1);
	assert(c1.lista(vector,10)==1);
	try {c1.inserta(8);}
	catch(const char * s) {assert(strcmp(s,"Inserta: Ya existe el elemento\n")==0);}
	
	//Prueba de contenedores con más de un elemento
	for(int i=0; i<50; i++)
		c2.inserta(i); //Inserto 50 elementos en c2
	assert(c2.tamano()==50);
	for(int i=0; i<50; i++)
		if(!c2.busca(i))
			cout << "El valor "<< i<<" no está."<<endl;
	try {c2.inserta(8);} //Insertar un valor repetido
	catch(const char * s) {assert(strcmp(s,"Inserta: Ya existe el elemento\n")==0);}
	int v[10];
	int nd=0,ne=0;
	try {ne=c2.lista(v,10);} //Prueba para contenedor mayor que vector
	catch(const char * s) {assert(strcmp(s,"Lista: Tamaño maximo del vector superado\n")==0);}
	c1.inserta(4);
	c1.inserta(12);
	c1.inserta(0);
	c1.inserta(10);
	try {nd=c1.lista(v,10);}
	catch(const char * s) {assert(strcmp(s,"Lista: Tamaño maximo del vector superado\n")==0);}

	for(int i=0; i<nd; i++)
		for (int j=0; j<i;j++)
			assert(v[i]>v[j]); //Compruebo que el vector esta ordenado

	//Prueba de constructor de copia
	Contenedor<int> c3(c2); 
	assert(c3.tamano()==50);
	for(int i=0; i<50; i++)
		if(!c3.busca(i))
			cout << "El valor "<< i<<" no está."<<endl;
	try {c3.inserta(8);} //Insertar un valor repetido
	catch(const char * s) {assert(strcmp(s,"Inserta: Ya existe el elemento\n")==0);}

	//Prueba de multiples elementos flotantes
	Contenedor<float> c4;
	for(float i=0; i<50; i++)
		c4.inserta(i); //Inserto 50 elementos en c2
	assert(c4.tamano()==50);
	for(float i=0; i<50; i++)
		if(!c4.busca(i))
			cout << "El valor "<< i<<" no está."<<endl;
	try {c4.inserta(8.0);} //Insertar un valor repetido
	catch(const char * s) {assert(strcmp(s,"Inserta: Ya existe el elemento\n")==0);}
	return 0;
}
