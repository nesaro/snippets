#include <cstdlib>
#include <climits>
#include <cfloat>
#include "fraccion.h"
using namespace std;

//LLamo a la función de reducción en el constructor, ahorrando
//Otras muchas llamadas

Fraccion::Fraccion(int a,int b)
{
	num=a;
	den=b;
	reducir();
}

int Fraccion::numerador() const{
	return num;
}

int Fraccion::denominador() const{
	return den;
}

float Fraccion::valor() const{
	if (!den) return FLT_MAX; //Aquí controlo si el numerador vale 0
	return (float)num/den;
}


//Ambos operadores (- y /) deben ser constantes, y trabajar con objetos constantes.

Fraccion Fraccion::operator -(const Fraccion & operando) const{
	return Fraccion((num*operando.den)-(den*operando.num),den*operando.den);
}

Fraccion Fraccion::operator / (const Fraccion &operando) const{
	return Fraccion(operando.den*num,operando.num*den);
}

Fraccion Fraccion::inversa() const{
	return Fraccion(den,num);
}

//Numeromixto controla la existencia o no del denominador,
//y devuelve cada uno de los parámetros

void Fraccion::numeroMixto(int& c,int& d, int& b) const
{
	if (!den) 
	{ 
		d=c=INT_MAX;
		b=0;
		return;
	}
	c=num/den;
	d=num%den;
	b=den;
	return;
}

Fraccion Fraccion::elevadoA(int exp) const
{
	int x,y;
	bool inverso=false;
	if(!den) return Fraccion(1,0); //No viene en la especificación, pero me parece
								   //el resultado más verosimil. (1/0)^3 es infinito
	if(!exp) return Fraccion(1,1); //un numero elevado a 0 es 1 siempre
	x=num;y=den;
	if(exp<0) {exp*=-1;inverso=true;} //inverso controla si tratamos con una potencia negat.
	while (exp>1)
	{
		x*=num;
		y*=den;
		exp--;
	}
	if(inverso) return Fraccion(y,x);
	return Fraccion(x,y);
	
}

//No tiene sentido que cada objeto posea la misma función,
//Asi que  euclides esta declarada como estática

int Fraccion::euclides(int m, int n)
{
	int t;
	if ((n < 1) || (m < 0)) return -1;
	while (m >0 )
	{
		t = n % m;
		n = m;
		m = t;
	}
	return n;
}

//Reducir obtiene la expresion única de cada fracción

void Fraccion::reducir()
{
	int signo=1;
	if (num<0) signo*=-1;
	if (den<0) signo*=-1;
	num=abs(num);
	den=abs(den);
	int t=euclides((num>den?den:num),(num>den?num:den));
	den/=t;
	num/=t;
	num*=signo;
	return;
}

//Los operadores friend trabajan sobre los dos operandos como const

Fraccion operator+(const Fraccion & f1, const Fraccion & f2)
{
	return Fraccion(f1.num*f2.den+f2.num*f1.den,f1.den*f2.den);
}

Fraccion operator*(const Fraccion & f1, const Fraccion & f2)	
{
	return Fraccion(f1.num*f2.num,f1.den*f2.den);
}
