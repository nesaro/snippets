#include "alfabeto.h"
#include <string>
#include <vector>
#include <list>
#include <map>
using namespace std;

#ifndef __CIFRADOR_H
#define __CIFRADOR_H

class Cifrador {
	public:
		void estableceClave(const vector<pair<string,string> > &clave);
		void cifra(const list<string> &textoClaro, list<string> &textoCifrado);
		void descifra(const list<string> &textoCifrado, list<string> &textoClaro);
	private:
		static string extraepalabra(string &); //Funcion auxiliar para cortar en bloques una cadena
		map<string,string> normal,inversa; //Maps donde voy a guardar la clave y la clave inversa
};

#endif
