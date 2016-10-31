#include <stdio.h>
#include "foro.h"
#include <assert.h>
int main()
{
    const char *nff="foro.dat";
    int idp, i, idm, nident, ident[10];
	char aut[20],tit[40],cont[1000];
	int reftemp;
    creaForo(nff);
    idp=ponMensaje(nff,"pepe","Primer mensaje","Contenido 1 ...",-1);
    nident=identificadoresMensajes(nff,ident,10);
    /*nident debe ser 3 e ident={1,2,3,...}   */
    for(i=0; i<nident; i++){
      char autor[20], titulo[40], contenido[1000];
      int referencia;
      leeMensaje(nff,ident[i],autor,titulo,contenido,&referencia);
      printf("%3d: %s => %s\n",ident[i],autor,titulo);
    }
    /*idp debe ser 0*/
	assert(idp==0);
    ponMensaje(nff,"juan","Otro mensaje","Contenido 2 ...",0);
    nident=identificadoresMensajes(nff,ident,10);
    /*nident debe ser 3 e ident={1,2,3,...}   */
    for(i=0; i<nident; i++){
      char autor[20], titulo[40], contenido[1000];
      int referencia;
      leeMensaje(nff,ident[i],autor,titulo,contenido,&referencia);
      printf("%3d: %s => %s\n",ident[i],autor,titulo);
    }
    idm=ponMensaje(nff,"antonio","Mas mensajes","Contenido 3 ...",-1);
	assert(idm==2);
    /*idm debe valer 2*/
    ponMensaje(nff,"pepe","Re:Mas mensajes","Bla, bla, ...",idm);
    printf("Mensajes almacenados %d \n", numeroMensajes(nff));
    /*debe mostrar 4*/ 
    anulaMensaje(nff,idp);
    printf("Mensajes almacenados %d \n", numeroMensajes(nff));
    /*debe devolver 3*/
	leeMensaje(nff,1,aut,tit,cont,&reftemp);
	printf("%3d: %s => %s\n,%s\n,%d\n",999,aut,tit,cont,reftemp);
    nident=identificadoresMensajes(nff,ident,10);
    /*nident debe ser 3 e ident={1,2,3,...}   */
    for(i=0; i<nident; i++){
      char autor[20], titulo[40], contenido[1000];
      int referencia;
      leeMensaje(nff,ident[i],autor,titulo,contenido,&referencia);
      printf("%3d: %s => %s\n",ident[i],autor,titulo);
    }
    printf("Busqueda\n");
    nident=buscaMensajes(nff,"Contenido",ident,1);
    for(i=0; i<nident; i++){
      char autor[20], titulo[40], contenido[1000];
      int referencia;
      leeMensaje(nff,ident[i],autor,titulo,contenido,&referencia);
      printf("Encontrado %3d: %s => %s\n",ident[i],autor,titulo);
    }
    return 0;
}
