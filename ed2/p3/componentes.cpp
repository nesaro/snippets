#include "componentes.h"
#include "math.h"

// Componente Genérico, funciones comunes

Componente::~Componente()
{
}

int Componente::npalabras() const //Un componente genérico contiene una palabra
{
	return 1;
}

// ComponenteNumero


string ComponenteNumero::aRistra() const
{
	char numero[16]; 
	sprintf(numero,"%d",valor); //Sprintf me pasa el entero a char*
	return numero;
}

ComponenteNumero::ComponenteNumero(int entrada)
{
	valor=entrada;
}

int ComponenteNumero::ncaracteres() const
{
	if (valor==0) 
		return 1;
	if (valor>0)
		return (int)log10(valor)+1;
	return (int)log10(valor*-1)+2; //Si es negativo sumo uno mas (el signo)
}

ComponenteNumero * ComponenteNumero::copia() const
{
	ComponenteNumero * temp = new ComponenteNumero(valor);
	return temp;
}

//Componente texto

string ComponenteTexto::aRistra() const 
{
	return contenido;
}

ComponenteTexto::ComponenteTexto(const char * entrada)
{
	contenido=entrada; 
}


//ncaracteres de componente texto solamente omite los espacios
int ComponenteTexto::ncaracteres() const
{
	unsigned int total=0;
	for (unsigned int i=0;i<contenido.size();i++)
		if (contenido[i]!=' ')
			total++;
	return total;
}

// Cuento las palabras a partir de los cambios de espacio a != espacio
int ComponenteTexto::npalabras() const
{
	unsigned int total=0;
	bool cambio=true;
	for (unsigned int i=0;i<contenido.size();i++)
	{
		if (cambio)
		{
			if (contenido[i]!=' ')
			{cambio=false;total++;}
		}
		else
			if (contenido[i]==' ')
				cambio=true;
	}
	return total;
}


ComponenteTexto * ComponenteTexto::copia() const
{
	ComponenteTexto * temp = new ComponenteTexto(contenido.c_str());
	return temp;
}

// ComponenteCompuesto


//El operador de asignacion

ComponenteCompuesto & ComponenteCompuesto::operator =(const ComponenteCompuesto& original)
{

	//Si contiene el mismo numero de elementos, compruebo que no se trata de la misma variable
	if (mfin==original.mfin)
	{
		for (int i=0;i<mfin;i++)
			if (contenedor[i]!=original.contenedor[i])
			{
				delete contenedor[i];
				contenedor[i]=original.contenedor[i]->copia();
			}
		return *this;
	}

	//Si no borro cada elemento
	for (int i=0;i<mfin;i++)
	{
		delete contenedor[i];
	}
	// Y creo copia de los nuevos
	for(int i=0;i<original.mfin;i++)
		contenedor[i]=original.contenedor[i]->copia();
	mfin=original.mfin;
	return *this;

}

ComponenteCompuesto::ComponenteCompuesto()
{
	mfin=0;
}

//Constructor de copia, crea copia de los elementos del original en vez de asignarlos
ComponenteCompuesto::ComponenteCompuesto(const ComponenteCompuesto &original)
{
	mfin=original.mfin;
	for (int i=0;i<mfin;i++)
		contenedor[i]=original.contenedor[i]->copia();

}

ComponenteCompuesto * ComponenteCompuesto::copia() const
{
	ComponenteCompuesto * temp = new ComponenteCompuesto;
	for (int i=0;i<mfin;i++)
		temp->anade(contenedor[i]->copia());
	return temp;
}

ComponenteCompuesto::~ComponenteCompuesto()
{
	for(int i=0;i<mfin;i++)
		delete contenedor[i];
}


void ComponenteCompuesto::anade(Componente * puntero)
{
	if (mfin==100)
		return; //Nos hemos pasado del vector
	contenedor[mfin++]=puntero;
}

//aRistra,npalabras,ncaracteres, simplemente sacan el resultado de unir todas las llamadas
//de sus elementos

string ComponenteCompuesto::aRistra() const
{
	string salida;
	for (int i=0;i<mfin;i++)
		salida += contenedor[i]->aRistra();
	return salida;
}

int ComponenteCompuesto::npalabras() const
{
	int salida=0;
	for (int i=0;i<mfin;i++)
		salida += contenedor[i]->npalabras();
	return salida;

}

int ComponenteCompuesto::ncaracteres() const
{
	int salida=0;
	for (int i=0;i<mfin;i++)
		salida += contenedor[i]->ncaracteres();
	return salida;

}


//ComponenteFecha

ComponenteFecha::ComponenteFecha(time_t dato)
{
	fecha=dato; 
}

//aRistra: Hago uso de el struct tm para obtener la ristra
string ComponenteFecha::aRistra() const
{
	struct tm *mifecha=gmtime(&fecha);
	string pepe;
	char temp[4];
	sprintf(temp,"%d",mifecha->tm_mday);
	pepe+=temp;
	pepe+="/";
	sprintf(temp,"%d",mifecha->tm_mon+1);
	pepe+=temp;
	pepe+="/";
	sprintf(temp,"%d",mifecha->tm_year+1900);
	pepe+=temp;
	return pepe;
}

//ncaracteres, necesito tambien el struct tm
int ComponenteFecha::ncaracteres() const
{
	int temp=0;
	struct tm *mifecha=gmtime(&fecha);
	temp+=(int)log10(mifecha->tm_mday);
	temp+=(int)log10(mifecha->tm_mon+1);
	return temp+8; // 2 por las barras, 4 por el año, y 2 por tener que sumar 1 a cada logaritmo
}
ComponenteFecha* ComponenteFecha::copia() const
{
	ComponenteFecha * temp = new ComponenteFecha(fecha);
	return temp;
}
