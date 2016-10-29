#include <iostream>
#include "polinomio.h"
#include <assert.h>
using namespace std;
int main()
{
	Polinomio p(5),q(0),r(1);
	p[0]=-1;
	p[1]=0;
	p[2]=1;
	p[3]=1.5;
	p[4]=2;
	p[5]=3;
	q[0]=3;
	r[0]=0;
	r[1]=0;
	//Pruebas de grado
	assert(p.grado()==5);
	assert(q.grado()==0);
	assert(r.grado()==1);
	assert((p+q).grado()==5);
	assert((r-q).grado()==1);
	assert((p*r).grado()==6);
	//pruebas de valor
	for(float i=-10; i<=10; i+=0.5)
	{
		assert(p.valor(i)==(-1+i*i+1.5*i*i*i+2*i*i*i*i+3*i*i*i*i*i));
		assert(q.valor(i)==3);
		assert(r.valor(i)==0);
	}
	//pruebas de muestra
	cout << "P vale: ";
	p.muestra();
	cout << "Q vale: ";
	q.muestra();
	cout << "R vale: ";
	r.muestra();
	cout << "P-R vale: ";
	(p-r).muestra();
	cout << "P-Q vale: ";
	(p-q).muestra();
	cout << "-P*R vale: ";
	((-p)*r).muestra();
	//prueba de operadores
	//// Operador []
	assert(p[0]==-1);
	assert(p[5]==3);
	r[1]=5;
	assert(r[1]==5);
	cout << "-P*R vale: ";
	((-p)*r).muestra();
	//// Operadores aritmeticos
	assert(-p[3]==-1.5);
	assert(-r[0]==r[0]);
	for(float i=-4; i<=4; i+=0.5)
	{
	assert(p.valor(i)==(p+q-q).valor(i));
	assert(r.valor(-i)==-r.valor(i));
	assert(((-p)*r).valor(i)==(5*i-5*i*i*i-7.5*i*i*i*i-10*i*i*i*i*i-15*i*i*i*i*i*i));
	}
	//// Operador de asignación
	q=p;
	q=q;
	for(int i=0; i<=q.grado(); i++)
		assert(q[i]==p[i]);
	//// Constructor de copia
	Polinomio s=p;
	for(int i=0; i<=s.grado(); i++)
		assert(s[i]==p[i]);

	return 0;
}
