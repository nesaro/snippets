#ifndef COLA
#define COLA

struct NodoCola;
typedef struct NodoCola TNodoCola, *PNodoCola;
struct Cola ;
typedef struct Cola TCola, *PCola;

void inicializa(PCola cola);
int inserta(PCola cola,int t);
int extrae(PCola cola);
int tamano(PCola cola);
void copia(PCola destino,PCola origen);
void destruye(PCola cola);
int examina(PCola cola);
int inicio(PCola cola);
int fin(PCola cola);
int avanza(PCola cola);
int retrocede(PCola cola);

struct NodoCola {
	PNodoCola siguiente;
	PNodoCola anterior;
	int contenido;
};

struct Cola {
	int size; /* En este entero guardo el tamaño */
	PNodoCola primero;
	PNodoCola ultimo;
	PNodoCola iterador;
};
#endif
