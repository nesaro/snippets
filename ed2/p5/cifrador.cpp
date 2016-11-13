#include "cifrador.h"


//estableceClave: Comprueba la salud de la clave
void Cifrador::estableceClave(const vector<pair<string,string> > &clave)
{
	map<string,string> tnormal,tinversa; //Map temporales
	vector<pair<string,string> >::const_iterator i; 
	for(i=clave.begin(); i!= clave.end();i++) //Recorrido del vector de entrada
	{
		Alfabeto mial; mial.inicializa();
		pair<string,string> temp("","");
		temp=*i;
		string primero= temp.first ; 
		string segundo= temp.second;
		//Comprobación de que las palabras pertenecen al alfabeto
		for(unsigned int j=0;j<primero.size();j++) if (!mial.esta(primero[j])) throw ("Hay una clave incorrecta");
		for(unsigned int j=0;j<segundo.size();j++) if (!mial.esta(segundo[j])) throw ("Hay un valor incorrecto");
		//Comprobación de que no existe previamente ni la clave ni el dato
		if ((tnormal.find(primero) != tnormal.end()) || (tinversa.find(segundo) != tinversa.end()))
			throw("Ya existe la clave");
		tnormal[primero]=segundo; //Asignación de la clave
		tinversa[segundo]=primero; //Asignación de la clave inversa
	}
	//Comprobación de que la clave de cifrado y descifrado son coherentes
	for(i=clave.begin(); i!= clave.end();i++)
	{
		pair<string,string> temp("","");
		temp=*i;
		string primero= temp.first ;
		string segundo= temp.second;
		if(primero!=tnormal[tinversa[primero]]) throw("La clave no es coherente");
	}
	//Ha superado las pruebas, hago la asignación a los elementos de la clase
	normal=tnormal;
	inversa=tinversa;
}

//cifra:  extrae cada elemento de la lista de texto, y lo procesa hasta obtener el texto cifrado
void Cifrador::cifra(const list<string> &textoClaro, list<string> &textoCifrado)
{
	for(list<string>::const_iterator it=textoClaro.begin(); it != textoClaro.end(); it++)
	{
		string texto=*it;
		string salida,palabra;
		while (texto.size() >0 )
		{
			palabra=extraepalabra(texto);
			if (normal[palabra].length()) //Comprobamos si puede ser sustituido
				palabra=normal[palabra];
			salida+=palabra;
		}
		textoCifrado.insert(textoCifrado.end(),salida);
	}
}


//descifra:  extrae cada elemento de la lista de texto, y lo procesa hasta obtener el texto descifrado
void Cifrador::descifra(const list<string> &textoCifrado, list<string> &textoClaro){
	for(list<string>::const_iterator it=textoCifrado.begin(); it != textoCifrado.end(); it++)
	{
		string texto=*it;
		string salida,palabra;
		while (texto.size() >0 )
		{
			palabra=extraepalabra(texto);
			if (normal[palabra].length())
				palabra=inversa[palabra];
			salida+=palabra;
		}
		textoClaro.insert(textoClaro.end(),salida);
	}

}

//extraepalabra: Función que extrae un bloque de una cadena y lo devuelve
string Cifrador::extraepalabra(string & entrada)
{
		Alfabeto mial;
		string salida;
		mial.inicializa();
		unsigned int i=0;
		if (mial.esta(entrada[0])) //El bloque es una palabra
			while (mial.esta(entrada[i]))
				i++;
		else  //El bloque no es una palabra
			while (!mial.esta(entrada[i]))  
				i++;
		if(entrada.size()<= i) { salida=entrada.substr(0,i); entrada=""; return salida;}
		salida=entrada.substr(0,i); //Cortamos la cadena de entrada
		entrada=entrada.substr(i,entrada.size()); 
		return salida;
}
