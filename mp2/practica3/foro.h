#ifndef FORO
#define FORO
/* Declaracion de funciones */
int creaForo(const char *nf);
int ponMensaje(const char *nf, const char *autor, const char *titulo, const char *contenido, int ref);
int leeMensaje(const char *nf, int ident, char *autor, char *titulo, char *contenido, int *ref);
int anulaMensaje(const char *nf, int ident);
int numeroMensajes(const char *nf);
int identificadoresMensajes(const char *nf, int identificadores[], int maxid);	
int buscaMensajes(const char *nf, const char *abuscar,  int identificadores[], int maxid);
#endif
