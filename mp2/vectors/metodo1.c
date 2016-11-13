#include <math.h>
#include <time.h>
#include "metodo1.h"

void metodo1(int vec[], int n,int *ncomp, int *nmov,float *tiempo)
{
	int i,cadadigito,digito,temp=0,colocador;
	int nd,varaux=1,varaux1=10;
	int cont[11],vectemp[n];
	int tinicial,tfinal;
	tinicial=(int)clock();
	*ncomp=0;*nmov=0;
	for (i=0;i<n;i++)
	{
		if (vec[i]>temp) temp=vec[i];
		*ncomp+=1;
	}
	nd=log10(temp)+1; //buscar con logaritmo del mayor
	temp=0;
	for (cadadigito=0;cadadigito<nd;cadadigito++)
	{
		/*Poner a 0 el vector de contadores */
		for (i=0;i<=10;i++)
		{
			cont[i]=0;
		}
		/*Ir modificando el vector de contadores para marcar*/
		for (i=0;i<n;i++)
		{
			digito=(vec[i] % varaux1)/varaux;
			cont[digito+1] = cont[digito+1]+1;
		}
		
		/*Hago la "integral" del vector para que sirva de marcador*/
		for (i=1;i<10;i++)
		{
			cont[i]=cont[i]+cont[i-1];
		}

		/* Bloque de asignaciones en el vector temporal*/
		for (i=0;i<n;i++){
			temp = vec[i];
			digito=(temp % varaux1)/varaux; /* Averiguo cual es su digito */
			colocador=cont[digito];
			vectemp[colocador]=temp; /*Lo coloco en el sitio */
			cont[digito]=cont[digito]+1; /*Desplazo 1 el marcador */
			*nmov+=1;
		}
		
		/* Bloque de copia del vector temporal al original */
		/* No puedo ahorrarme la última copia porque devuelvo vec */
		/* Y no el vector temporal */
		for (i=0;i<n;i++)
		{
			vec[i]=vectemp[i];
			*nmov+=1;
		}
		varaux=varaux1;
		varaux1=varaux1*10;
	}
	tfinal=(int)clock();
	*tiempo=(float)(tfinal-tinicial);
	*tiempo/=CLOCKS_PER_SEC;
	return;
}

