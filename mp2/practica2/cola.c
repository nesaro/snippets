#include <stdlib.h>
#include "cola.h"

/* inicializa: Tamaño a 0 y el resto nulo */
void inicializa(PCola cola){
	cola->size=0;
	cola->primero=NULL;
	cola->ultimo=NULL;
	cola->iterador=NULL;
	return;
}

/* Inserta, dividido en dos etapas */

int inserta(PCola cola,int t){
	PNodoCola temp;
	/* No hay elementos, tengo que crear el primero, que ademas será el último */
	if (cola->size==0)
	{
		cola->primero=(PNodoCola)malloc(sizeof(TNodoCola));
		if (cola->primero==NULL)/* Comprobación de creación */
			return 0;
		cola->primero->anterior=NULL;
		cola->primero->siguiente=NULL;
		cola->primero->contenido=t;
		cola->ultimo=cola->primero;
		cola->size=1;
		cola->iterador=cola->primero;
		return 1;
	}
	/* Si hay algun elemento, creo uno y lo pongo como el siguiente del último */
	temp=cola->ultimo;
	cola->ultimo=(PNodoCola)malloc(sizeof(TNodoCola)); 
	if (cola->ultimo==NULL) /* Comprobación de creación */
		return 0;
	cola->ultimo->anterior=temp;
	cola->ultimo->siguiente=NULL;
	cola->ultimo->contenido=t;
	temp->siguiente=cola->ultimo;
	cola->size++;
	return 1;
}
/* Extrae, divido en tres etapas */
int extrae(PCola cola){
	PNodoCola temp;
	/* 0 elementos: devuelvo 0 */

	if (cola->size==0)
		return 0;

	/* 1 elemento: todo puesto a nulo, tamaño=0 */

	if (cola->size==1)
	{ 
		free(cola->primero);
		cola->primero=NULL;
		cola->iterador=NULL;
		cola->ultimo=NULL;
		cola->size=0;
		return 1;
	}

	/* mas de 1 elemento: quito el primero, el segundo pasa 
	 * a ser el primero, decremento tamaño */

	if (cola->iterador==cola->primero) /* Si el iterador es el primero, */
		cola->iterador=cola->primero->siguiente; /* pasa al segundo */
	temp=cola->primero;
	cola->primero=cola->primero->siguiente;
	cola->primero->anterior=NULL;
	free(temp);
	cola->size--;
	return 1;
}
int tamano(PCola cola)
{
	return (int)cola->size;
}

/* Copia: */
void copia(PCola destino,PCola origen){ 
	PNodoCola temp;
	if (tamano(origen)==0) /* Origen no debe estar vacio*/
		return;
	while((tamano(destino))>0) /* Borrado de la cola destino */
	{
		extrae(destino);
	}
	temp = origen->iterador; /* Almaceno temporalmente el iterador */
	inicio(origen);
	inserta(destino,examina(origen));
	while (avanza(origen)) /* Recorro la cola origen,y la voy insertando */
	{
		inserta(destino,examina(origen));
		/* Si he llegado al elemento que estaba señalado,fijo el iterador
		 * en el final de destino */
		if (origen->iterador==temp) 
			fin(destino);
	}
	origen->iterador=temp; /* Recolocar el iterador en origen */

}

/* Destruye: */
void destruye(PCola cola)
{
	PNodoCola temp,temp2;
	temp = cola->primero;
	/* Recorro la cola borrando cada elemento */
	while(temp!=NULL)
	{
		temp2=temp->siguiente;
		free(temp);
		temp=temp2;
	}
	/* Todos los punteros a nulo */
	cola->primero=NULL;
	cola->ultimo=NULL;
	cola->iterador=NULL;
}	

/* Examina */
int examina(PCola cola)
{
	if (cola->size==0) /* si esta vacio devuelve 0 */
		return 0;
	if (cola->iterador==NULL) /* si el iterador señala a nulo, devuelve 0 */
		return 0;
	return cola->iterador->contenido;
}

/* Incio */
int inicio(PCola cola)
{
	if (cola->size==0)
		return 0;
	cola->iterador=cola->primero;
	return 1;
}

/* Fin */
int fin(PCola cola){
	if (cola->size==0)
		return 0;
	if (cola->size==1)
		cola->iterador=cola->primero;
	cola->iterador=cola->ultimo;
	return 1;
}

/* Avanza: comprueba los posibles fallos antes de avanzar el iterador*/ 
int avanza(PCola cola){
	if (cola->size==0)
		return 0;
	if (cola->iterador == NULL)
		return 0;
	if (cola->iterador->siguiente == NULL)
		return 0;
	cola->iterador=cola->iterador->siguiente;
	return 1;
}

/* Retrocede: comprueba los posibles fallos antes de avanzar el iterador*/ 
int retrocede(PCola cola){
	if (cola->size==0)
		return 0;
	if (cola->iterador == NULL)
		return 0;
	if (cola->iterador->anterior == NULL)
		return 0;
	cola->iterador=cola->iterador->anterior;
	return 1;
}

