#include <stdio.h>
#include <time.h>
#include "metodo2.h"
#define IC(a,b) {a=a^b;b=a^b;a=a^b;}
/*IC es una macro de intercambio*/

void metodo2(int vec[], int n,int *ncomp, int *nmov,float *tiempo){

	int i,j,dirty;
	long int tinicio,tfinal;
	tinicio=(int)clock();
	*nmov=0;*ncomp=0;
	/*Bucle de recorrido de todos los elementos*/
	for (j=0;j<n;j++)
	{
		/* dirty indica si ha habido cambio*/
		dirty=0;
		/* Bucle de recorrido de intercambio */
		for (i=j%2;i<(n-1);i=i+2)
		{
			*ncomp+=1;
			if (vec[i] > vec[i+1])
			{
				IC(vec[i],vec[i+1])
				dirty=1;
				*nmov+=2;
			}
		}
		/*Compruebo si ya esta ordenado*/
		if ((!dirty) && (j>1))
		{
			tfinal=(int)clock();
			*tiempo=(float)(tfinal-tinicio)/CLOCKS_PER_SEC;
			return;
		}
	}
	tfinal=(int)clock();
	*tiempo=(float)(tfinal-tinicio)/CLOCKS_PER_SEC;
	return;
}
			
			
