#include <iostream>
#include "polinomio.h"
using namespace std;

Polinomio::Polinomio(int n)
{
	datos = new float[n+1]; //Reservo el vector de flotantes
	maxexp = n;
	for (int i=0;i<maxexp+1;i++)
		datos[i]=0; //Valor por defecto
}	

Polinomio::~Polinomio()
{
	delete datos;
}

float& Polinomio::operator[](int pos) const
{
	return datos[pos];
}

//Operador de asignacion
Polinomio & Polinomio::operator= (const Polinomio & a){
	
	//solo modifico la memoria si hay diferencia en los grados
	//De esta forma garantizo que no hay problemas en la autoasignacion

	if(maxexp!=a.maxexp)
	{
	maxexp=a.maxexp;
	delete[] datos;
	datos = new float[maxexp+1];
	}
	for (int i=0;i<=maxexp;i++)
	{
		datos[i]=a.datos[i];
	}
	return *this; //Como en el resto de asignaciones de c++, devuelvo el objeto
} 

//Constructor de copia
Polinomio::Polinomio(const Polinomio & a)
{

	//En el constructor de copia siempre reservo la memoria
	//Ya que voy a crear un nuevo objeto
	maxexp=a.maxexp;
	datos=new float[maxexp+1];
	for (int i=0;i<=maxexp;i++)
	{
		datos[i]=a.datos[i];
	}
}

int Polinomio::grado() const
{
	return maxexp;
}

float Polinomio::valor(float x) const
{
	float temp=1,resultado=0;
	for(int i=0;i<=maxexp;i++)
	{
		resultado+= datos[i]*temp;
		temp*=x;
	}
	return resultado;	
}

//Muestra añade el signo + al principio de los elementos positivos,
//Omite los 1, y pone el exponente al lado de cada valor.
void Polinomio::muestra() const
{
	bool valido=false;
	//Maximo exponente
	if (datos[maxexp] && maxexp>0) 
	{
		cout << datos[maxexp] << "*(x^" << maxexp << ")";
		valido=true; //Valido comprueba si ha habido algun valor distinto de 0
	}
	//Exponentes intermedios
	for (int i=maxexp-1;i>0;i--)
		if (datos[i]) 
		{
			if (datos[i]>0 && datos[i]!=1)
				cout << "+";
			if (datos[i]!=1 && datos[i]!=-1) 
				cout << datos[i] << "*";
			if (datos[i]==-1)
				cout << "-";
			cout <<	"(x^" << i << ")";
			valido=true;
		}
	//Ultimo exponente y caso extremo de polinomio 0
	if (!valido && !datos[0])
		cout << 0;
	else
	{
		if(datos[0]>0) 
			cout << "+";
		if(datos[0])
			cout << datos[0];
	}
	cout << "\n";
		
}

//Operadores suma y resta: uso dos referencias para saber cual es el mayor y el menor

Polinomio operator +(const Polinomio & a ,const Polinomio & b)
{
	const Polinomio &mayor=(a.grado()>b.grado()?a:b);
	const Polinomio &menor=(a.grado()>b.grado()?b:a);
	Polinomio temp(mayor.grado());
	int i=0;
	for (i=0;i<=menor.grado();i++) //Hay exponentes en comun
	{
		temp[i]=a[i]+b[i];
	}
	for(i=menor.grado()+1;i<=mayor.grado();i++) //No hay exponentes en comun
	{
		temp[i]=mayor[i];
	}
	return temp;
}

Polinomio operator -(const Polinomio & a ,const Polinomio & b)
{
	const Polinomio &mayor=(a.grado()>b.grado()?a:b);
	const Polinomio &menor=(a.grado()>b.grado()?b:a);
	Polinomio temp(mayor.grado());
	int i=0;
	for (i=0;i<=menor.grado();i++) //Exponentes en comun
	{
		temp[i]=a[i]-b[i];
	}
	if(&mayor==&a) //El primero es el mayor, los exponentes que quedan son positivos
	{
		for(i=menor.grado()+1;i<=mayor.grado();i++)
		{
			temp[i]=a[i]; 
		}
	}
	else //El segundo es el mayor, los exponentes que quedan tienen que negarse
	{
		for(i=menor.grado()+1;i<=mayor.grado();i++)
		{
			temp[i]=-b[i];
		}
	}		
	return temp;
	
}

Polinomio operator -(const Polinomio & a) 
{
	Polinomio temp(a.grado());
	for (int i=0;i<=temp.grado();i++)
	{
		temp[i]=-a[i];
	}
	return temp;
}

//La multiplicacion es un doble bucle, Para cada exponente del primer polinomio,
//multiplico por todos los del segundo polinomio, y voy sumando en el resultado.

Polinomio operator *(const Polinomio & a ,const Polinomio & b)
{
	Polinomio temp(a.grado()+b.grado());
	for (int i=0;i<=a.grado();i++)
		for (int j=0;j<=b.grado();j++)
			temp[j+i]+=a[i]*b[j];
	return temp;
}

	
