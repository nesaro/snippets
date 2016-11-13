#include <iostream>
#include "cifrador.h"
typedef pair<string,string> Pareja;
int main() {
	Cifrador c;
	vector<Pareja> clave;
	clave.push_back(Pareja("un","flaco"));
	clave.push_back(Pareja("lanza","un"));
	clave.push_back(Pareja("de","hidalgo"));
	clave.push_back(Pareja("flaco","de"));
	clave.push_back(Pareja("la","lanza"));
	clave.push_back(Pareja("hidalgo","la"));
	try {
	c.estableceClave(clave);
	}
	catch (const char * s)
	{
		cout << s;
	}
	list<string> texto, cifrado, descifrado;
	texto.push_back("En un lugar de la Mancha, de cuyo nombre no quiero acordarme,");
	texto.push_back(" no ha mucho tiempo que vivía un hidalgo de los de lanza en astillero,");
	cout << "Texto a cifrar" << endl;
	for(list<string>::iterator i=texto.begin(); i!= texto.end(); i++)
		cout << *i << endl;
	c.cifra(texto,cifrado);
	cout << "Texto cifrado" << endl;
	for(list<string>::iterator i=cifrado.begin(); i!= cifrado.end(); i++)
		cout << *i << endl;
	c.descifra(cifrado,descifrado);
	cout << "Texto descifrado" << endl;
	for(list<string>::iterator i=descifrado.begin(); i!= descifrado.end(); i++)
		cout << *i << endl;
	return 0;
} 
