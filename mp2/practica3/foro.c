#include "foro.h"
#include <string.h>
#include <stdio.h>

/* La estructura mmensaje sera la referencia
 * a la hora de trabajar con el fichero */

struct mmensaje{
	int referencia;
	int anulado;
	char autor[20];
	char titulo[40];
	char contenido[1000];
};

/* mensaje = struct mmensaje */
typedef struct mmensaje mensaje;


int creaForo(const char *nf)
{
	FILE *fichero;
	fichero=fopen(nf,"wb"); /*modo de escritura binario */
	if (fichero)
		fclose(fichero); /*Cierro el fichero*/
	return fichero!=NULL;
}
int ponMensaje(const char *nf, const char *autor, const char *titulo, const char *contenido, int ref)
{
	FILE *fichero;
	mensaje temp; /*temp es el mensaje que voy a insertar */
	int pos;
	if (strlen(autor)>19 || strlen(titulo)>39 || strlen(contenido)>999) /* Comprobacion de tamaño */
		return -1;
	if ((ref!=-1) && (!leeMensaje(nf,ref,temp.autor,temp.titulo,temp.contenido,&temp.referencia))) /* El mensaje debe tener una referencia valida */
		return -1;
	fichero=fopen(nf,"ab"); 
	if (!fichero)
		return -1;
	temp.referencia=ref;
	temp.anulado=0;
	strcpy(temp.titulo,titulo);
	strcpy(temp.autor,autor);
	strcpy(temp.contenido,contenido);
	/*La posicion en la que voy a escribir la averiguo antes de escribir*/
	pos=ftell(fichero)/sizeof(mensaje); 
	if ((fwrite(&temp,sizeof(mensaje),1,fichero)) != 1) /*fwrite debe devolver 1 */
	{fclose(fichero);return -1;}
	fclose(fichero);
	return pos;
}
int leeMensaje(const char *nf, int ident, char *autor, char *titulo, char *contenido, int *ref)
{
	FILE *fichero;
	mensaje temp; /* En temp guardo el mensaje */
	fichero=fopen(nf,"rb"); /* Solo necesito lectura */
	if (!fichero) return 0;
	if (fseek(fichero,ident*sizeof(mensaje),SEEK_SET)){fclose(fichero);return 0;}
	if ((fread(&temp,sizeof(mensaje),1,fichero)) !=1 ){fclose(fichero);return 0;}
	if (temp.anulado) {fclose(fichero);return 0;} /*revisamos que todo esta en orden antes de operar */
	*ref=temp.referencia;
	strcpy(titulo,temp.titulo);
	strcpy(autor,temp.autor);
	strcpy(contenido,temp.contenido);
	fclose(fichero);
	return 1;
}
int anulaMensaje(const char *nf, int ident)
{
	FILE *fichero;
	mensaje temp;
	fichero=fopen(nf,"rb+");
	if (!fichero)
		return 0;
	/* con fseek busco la instruccion, de forma absoluta */
	if (fseek(fichero,ident*sizeof(mensaje),SEEK_SET)) {fclose(fichero);return 0;}
	if (!fread(&temp,sizeof(mensaje),1,fichero)) {fclose(fichero);return 0;}
	if (temp.anulado) {fclose(fichero);return 0;}
	temp.anulado=1; /*Aqui hago el cambio */
	/* despues de la lectura pongo el cursor en la misma posicion */
	if (fseek(fichero,ident*sizeof(mensaje),SEEK_SET)) {fclose(fichero);return 0;}
	if ((fwrite(&temp,sizeof(mensaje),1,fichero)) != 1) {fclose(fichero);return 0;}
	fclose(fichero);
	return 1;
}
int numeroMensajes(const char *nf)
{
	FILE *fichero;
	int p=0;
	mensaje temp;
	fichero=fopen(nf,"rb");
	if (!fichero)
		return -1;
	/* recorro el fichero solo contando los vigentes */
	while (fread(&temp,sizeof(mensaje),1,fichero))
	{
		if (!temp.anulado)
			p++;
	}
	fclose(fichero);
	return p;
}
int identificadoresMensajes(const char *nf, int identificadores[], int maxid)
{
	FILE *fichero;
	mensaje temp;
	int i=0,j=0; /*j variable de identificadores, i variable del vector */
	fichero=fopen(nf,"rb");
	if (!fichero)
		return -1;
	/* Recorro el fichero rellenando el vector con los que no estan anulados*/
	while (fread(&temp,sizeof(mensaje),1,fichero))
	{
		if (!temp.anulado)
		{
			identificadores[i]=j;
			i++;
			if (i==maxid) /* Ha llegado al tope  del vector*/
				break;
		}
		j++;
	}
	fclose(fichero);
	return i;
}

int buscaMensajes(const char *nf, const char *abuscar,  int identificadores[], int maxid)
{	
	FILE *fichero;
	mensaje temp;
	int i=0,j=0;
	fichero=fopen(nf,"rb");
	if (!fichero)
		return -1;
	/* recorro el fichero */
	while (fread(&temp,sizeof(mensaje),1,fichero))
	{
		/* Para considerar el mensaje como valido, tiene que contener la cadena
		 * y no estar anulado */
		if (!temp.anulado && strstr(temp.contenido,abuscar))
		{
			identificadores[i]=j;
			i++;
			if (i==maxid) /* Ha llegado el tope del vector */
				break;
		}
		j++;
	}
	fclose(fichero);
	return i;
}
