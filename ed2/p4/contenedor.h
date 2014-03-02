#include <iostream>
#ifndef __CONTENEDOR_H
#define __CONTENEDOR_H
using namespace std;

// DECLARACION ARBOL
// Arbol es un arbol binario simple, sin funciones que gestionen
// la cantidad de elementos

template <class T> class arbol
{
	public:
		arbol(T entrada);
		arbol(const arbol &);
		arbol & operator=(const arbol &);
		~arbol();
		bool anade(T objeto);
		bool buscar(T objeto) const;
		void tovec(T v[],int &) const;
	private:
		arbol *izq,*der; //Los hijos son punteros a árbol.
		T contenido;
};

//DECLARACION CONTENEDOR

template <class T> class Contenedor{
	public:
		Contenedor();
		Contenedor(const Contenedor &);
		Contenedor & operator=(const Contenedor &);
		~Contenedor();
		bool busca(T x) const;
		void inserta(T x);
		int lista(T v[],int max) const;
		int tamano() const;
	private:
		int tam;
		arbol<T> *contenido;

};


//FUNCIONES ARBOL

//Constructor
template <class T> arbol<T>::arbol(T entrada){contenido=entrada; der=izq=NULL;}

//Constructor de copia
template <class T> arbol<T>::arbol(const arbol & original)
{
	izq=der=NULL; //Inicialmente los hijos son nulos
	if (original.izq) //Copio en caso de que exista cada hijo
		izq=new arbol<T>(*original.izq);
	if (original.der)
		der=new arbol<T>(*original.der);
	contenido=original.contenido; //Finalmente asigno el contenido
}

//Operador de asignación
template <class T> arbol<T> & arbol<T>::operator=(const arbol & original) 
{
	if(&original!=this)
	{
		contenido=original.contenido; //copia de contenido
		delete izq;delete der; //borro los hijos que existian antes.
		izq=der=NULL;
		if (original.izq) //Y asigno los nuevos.
			izq=new arbol(*original.izq);
		if (original.der)
			der=new arbol(*original.der);
	}
	return *this;
}

//Destructor
template <class T> arbol<T>::~arbol(){delete izq;delete der;}

//Anade: Añade un elemento tipo T. Recorre el arbol, si encuentra el
//elemento devuelve falso, en otro caso compara el elemento del nodo actual 
//y decide por que rama seguir llamando. Si encuentra una rama nula, creará
//el nuevo nodo ahí.
template <class T> bool arbol<T>::anade(T objeto)
{
	if (contenido==objeto) return false; //Ya existe
	if (contenido>objeto)  //Es menor
	{
		if (izq) return izq->anade(objeto); //sigo por la izq.
		izq=new arbol(objeto); //Creo un nodo nuevo
		return true;
	}
	if (der) return der->anade(objeto); //sigo por la derecha
	der=new arbol(objeto); //Creo un nodo nuevo
	return true;
}

//Buscar: Devuelve verdadero si el elemento existe
template <class T> bool arbol<T>::buscar(T entrada) const
{
	if (contenido==entrada) return true;
	if (contenido>entrada) 
		if (izq) return izq->buscar(entrada); //Sigo por la izq
		else return false; //He llegado a nulo
	if (der) return der->buscar(entrada);  //Sigo por la der
	else return false; //He llegado a nulo
}

//Tovec: Convierte el arbol en un vector, en orden.
//pos actua como marcador comun a todas las llamadas.
template <class T> void arbol<T>::tovec(T v[],int & pos) const
{
	if(izq) izq->tovec(v,pos);
	v[pos]=contenido;
	pos++;
	if(der) der->tovec(v,pos);
}


//FUNCIONES CONTENEDOR

//Constructor
template <class T> Contenedor<T>::Contenedor() { tam=0; }

//Constructor de copia
template <class T> Contenedor<T>::Contenedor(const Contenedor & original) 
{ 
	if (!original.tam) tam=0; //Si esta vacio no se copia el contenido
	else
	{ 
		tam=original.tam; 
		contenido=new arbol<T> (*original.contenido);
	}
}

//Operador de asignación
template <class T> Contenedor<T> & Contenedor<T>::operator=(const Contenedor & original) 
{
	if (&original!=this) //Compruebo que no se trata del mismo vector
	{
		if (tam) delete contenido; //No tenia contenido nulo
		tam=original.tam;
		if (tam) contenido=new arbol<T>(*original.contenido);
	}
	return *this;
}

//Destructor
template <class T> Contenedor<T>::~Contenedor() { if (tam>0) delete contenido;}

//Busca: busca un elemento en el contenedor, devuelve verdadero si lo encuentra.
template <class T> bool Contenedor<T>::busca(T x) const 
{ 
	if (tam) return contenido->buscar(x); 
	return false;
}

//lista: Pasa el contenido a una lista. Comprueba si es posible, lanzando una 
//excepción cuando no es así.
template <class T> int Contenedor<T>::lista(T v[],int max) const 
{
	if(max<tam) //El contenido no cabe en el vector
		throw("Lista: Tamaño maximo del vector superado\n");
	int i=0;
	if (tam)
		contenido->tovec(v,i); //LLamada para la raiz de la funcion tovec
	return tam;
}

//Inserta: Inserta un elemento tipo T.
template <class T> void Contenedor<T>::inserta(T x)
{
	if (tam==0) //Si es el primer elemento creo el arbol
		contenido= new arbol<T>(x);
	else
		if (!contenido->anade(x)) //Si no llamo a anade, comprobando a su vez si Ya existe
			throw("Inserta: Ya existe el elemento\n"); 
	tam+=1;
}

//tamano: devuelve el tamaño del Contenedor
template <class T> int Contenedor<T>::tamano() const {return tam;}
#endif
