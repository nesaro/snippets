#include "cola.h"
#include <assert.h>

int main(){
	int i,j;
	TCola cola, copiacola;
	inicializa(&cola);        /* cola=[] */
	inserta(&cola,4);     
	inserta(&cola,8);    /* Dos elementos en la cola */ 
	assert(tamano(&cola)==2);
	assert(examina(&cola)==4);
	fin(&cola); /* Me voy al 8 */
	assert(tamano(&cola)==2);
	assert(examina(&cola)==8);
	inicio(&cola);
	avanza(&cola);
	assert(tamano(&cola)==2);
	assert(examina(&cola)==8);
	retrocede(&cola); /*Vuelvo al 4 */
	assert(tamano(&cola)==2);
	assert(examina(&cola)==4);
	assert(extrae(&cola)==1); /*extraigo un elemento */
	inicio(&cola);
	assert(tamano(&cola)==1);
	assert(examina(&cola)==8);
	fin(&cola);
	assert(tamano(&cola)==1);
	assert(examina(&cola)==8);
	inicio(&cola);
	avanza(&cola);
	assert(tamano(&cola)==1);
	assert(examina(&cola)==8);
	retrocede(&cola);
	assert(tamano(&cola)==1);
	assert(examina(&cola)==8);
	assert(extrae(&cola)==1); /* Ahora dejo la cola vacia */

	inicio(&cola);
	assert(tamano(&cola)==0);
	assert(examina(&cola)==0);
	fin(&cola);
	assert(tamano(&cola)==0);
	assert(examina(&cola)==0);
	inicio(&cola);
	avanza(&cola);
	assert(tamano(&cola)==0);
	assert(examina(&cola)==0);
	retrocede(&cola);
	assert(tamano(&cola)==0);
	assert(examina(&cola)==0);

	/*Cola grande, 10 elementos */
	for(i=0; i< 10; i++)
	{	
		inserta(&cola,i);
	}
	/* cola=[(0), 1, 2, 3, 4, 5, 6, 7, 8, 9] */
	inicio(&cola);
	assert(tamano(&cola)==10);
	assert(examina(&cola)==0);
	extrae(&cola);
	assert(tamano(&cola)==9);
	assert(examina(&cola)==1);
	avanza(&cola);           
	assert(examina(&cola)==2);
	extrae(&cola);
	assert(examina(&cola)==2);
	fin(&cola);              /* cola=[2, 3, 4, 5, 6, 7, 8, (9)] */
	assert(examina(&cola)==9);
	retrocede(&cola);        /* cola=[2, 3, 4, 5, 6, 7, (8), 9] */
	assert(examina(&cola)==8);
	assert(tamano(&cola)==8);
	/* Copia de colas */
	inicializa(&copiacola);  /* copiacola=[] */
	avanza(&cola);
	copia(&copiacola,&cola); 
	/* Comparacion de las dos colas */
	assert(examina(&cola)==examina(&copiacola));
	inicio(&cola);inicio(&copiacola);
	/* Las iteraciones de mas comprueban que no ocurre nada al avanzar despues del final */
	for (j=0;j<15;j++)
	{
		assert(examina(&cola)==examina(&copiacola));
		avanza(&cola);avanza(&copiacola);
	}
	fin(&cola);fin(&copiacola);
	for (;j>=0;j--)
	{
		assert(examina(&cola)==examina(&copiacola));
		retrocede(&cola);retrocede(&copiacola);
	}

	/* Fin comparacion dos colas */
	return 0;

}
