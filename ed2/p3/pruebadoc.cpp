#include <time.h>
#include <iostream>
#include "componentes.h"
#include "pcomponente.h"
using namespace std;

int main()
{
	string errores="ERROR";
	time_t abril30 = 1114852778;
	time_t mayo1= 1114941156;
	time_t nov2671= 59999000;
	ComponenteNumero numerotemp(-1030400);
	ComponenteTexto textotemp("");
	ComponenteFecha fechatemp(mayo1);

	//Prueba de componentes básica
	ComponenteTexto * texto = new ComponenteTexto("Esto es un texto");
	ComponenteNumero * numero = new ComponenteNumero(314);
	ComponenteFecha * fecha = new ComponenteFecha(abril30);
	pruebaComponente(*texto,"Esto es un texto",13,4,errores);
	pruebaComponente(*numero,"314",3,1,errores);
	pruebaComponente(*fecha,"30/4/2005",9,1,errores);
	pruebaComponente(numerotemp,"-1030400",8,1,errores);
	pruebaComponente(textotemp,"",0,0,errores);
	//0 y negativos
	pruebaComponente(*new ComponenteNumero(0),"0",1,1,errores);
	pruebaComponente(*new ComponenteNumero(-1),"-1",2,1,errores);
	//Fechas con otras cantidades de digitos
	pruebaComponente(*new ComponenteFecha(mayo1),"1/5/2005",8,1,errores);
	pruebaComponente(*new ComponenteFecha(nov2671),"26/11/1971",10,1,errores);
    	
	
	// Prueba de componente compuesto

	ComponenteCompuesto * suma = new ComponenteCompuesto;
	suma->anade(texto);
	suma->anade(numero);
	suma->anade(fecha);
	pruebaComponente(*suma,"Esto es un texto31430/4/2005",25,6,errores);
	ComponenteCompuesto padre;
	padre.anade(suma);
	padre.anade(new ComponenteNumero(0));
	pruebaComponente(padre,"Esto es un texto31430/4/20050",26,7,errores);

	// Prueba de asignacion
	
	ComponenteCompuesto copia=padre;
	pruebaComponente(copia,"Esto es un texto31430/4/20050",26,7,errores);
	copia=copia; // Probando la asignacion a si mismo
	pruebaComponente(copia,"Esto es un texto31430/4/20050",26,7,errores);
	ComponenteNumero minumero(123093);
	minumero=*numero;
	pruebaComponente(minumero,"314",3,1,errores);
	minumero=minumero;
	pruebaComponente(minumero,"314",3,1,errores);
	pruebaComponente(numerotemp=minumero,"314",3,1,errores);
	pruebaComponente(minumero,"314",3,1,errores);
	pruebaComponente(textotemp=*texto,"Esto es un texto",13,4,errores);
	pruebaComponente(fechatemp=*fecha,"30/4/2005",9,1,errores);
	

	//Prueba de constructor copia
	ComponenteCompuesto clon(padre);
	pruebaComponente(clon,"Esto es un texto31430/4/20050",26,7,errores);
	
	//Prueba del tope de ComponenteCompuesto
	ComponenteCompuesto numeros;
	for (int i=0;i<100;i++)
	{
		pruebaComponente(numeros,numeros.aRistra(),i,i,errores);
		numeros.anade(new ComponenteNumero(0));
	}
	for (int i=100;i<200;i++)
		numeros.anade(new ComponenteNumero(0));

	//Todos los objetos creado con new desaparecen con los destructores
	return 0;
	
}
