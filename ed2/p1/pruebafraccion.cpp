#include "fraccion.h"
#include <assert.h>

int main()
{
	const int NV=10;
	int j,k,l;
	Fraccion a;
	Fraccion vector[NV];
	const Fraccion b(2,3), c(-1);
	//pruebas genéricas
	assert(a.numerador()==0);
	assert(a.denominador()==1);
	assert(b.numerador()==2);
	assert(b.denominador()==3);
	assert(c.numerador()==-1);
	assert(c.denominador()==1);
	//valor
	assert(a.valor()==0);
	//prueva de inversa
	assert(b.numerador()==b.inversa().denominador());
	assert(b.denominador()==b.inversa().numerador());
	//pruebas de operadores simples
	a=b-c;
	assert(a.numerador()==5);
	assert(a.denominador()==3);
	a=b/c;
	assert(a.numerador()==-2);
	assert(a.denominador()==3);
	//NumeroMixto
	a.numeroMixto(j,k,l);
	assert(j==0);
	assert(k==-2);
	assert(l==3);
	(b-a).numeroMixto(j,k,l);
	assert(j==1);
	assert(k==1);
	assert(l==3);
	//ElevadoA
	assert(a.elevadoA(-3).numerador()==-27);
	assert(a.elevadoA(3).denominador()==27);
	a=0;
	assert(a.elevadoA(100).numerador()==0);
	assert(a.elevadoA(100).denominador()==1);
	a=b/a;
	assert(a.elevadoA(100).numerador()==1);
	assert(a.elevadoA(100).denominador()==0);
	//Operadores friend
	a=b*c;
	assert(a.numerador()==-2);
	assert(a.denominador()==3);
	a=b+c;
	assert(a.numerador()==-1);
	assert(a.denominador()==3);
	a=a+b/3; //Prueba de expresion compleja
	assert(a.numerador()==-1);
	assert(a.denominador()==9);
	a=1+a; //la funcion friend debe permitir la conversion de entero
		   //para el primer operando
	assert(a.numerador()==8);
	assert(a.denominador()==9);
	return 0;
}
