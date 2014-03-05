#include <stdio.h>

int A(int m, int n)
{
	/* Las condiciones tal y como son exigidas en el enunciado */
	if (m < 0 || n < 0) return 0;
	if (!m) return n+1;
	if (!n) return A(m-1,1);
	return A(m-1,A(m,n-1));
}

void divisionReal(int a, int b, float * c, float * d)
{
	if (b==0) /* El denominador es 0 */
	{
		*c=0.;
		*d=2.;
		return;
	}
	*c=a/b; /* Como es division de enteros, el resultado es entero */
	*d=(float)a/(float)b - *c;
}

void secuenciaNegativos(int * vector, int n, int * devolucion, int * ndevolucion)
{
	int i=0,j,principio=0,posfin=0,msize=0;
	n--;
	while (vector[i]<0 && i<n) /* while para controlar los primeros negativos */
	{
		i++;
	}
	msize=i;
	for (;i<n;i++) /* for que comienza donde lo dejo el while */
	{
		if ((vector[i]^vector[i+1])<0) /* hay cambio de signo */
		{
			if (vector[i]>0) /*si es positivo, el siguiente sera el principio de una sec. neg*/
			{
				principio=i+1;
			}
			else /* Si no, es el final de la sec. negativa */
			{
				if ((i-principio+1) > msize) /* la condicion para guardar: es mayor que la mayor
												cadena encontrada hasta ahora */
				{
					posfin=principio;
					msize=(i-principio+1);
				}

			}
		}
	}

/* Una vez acabado el for, debemos vigilar si el último puede hacer la última cadena
 * más larga */
if((vector[n]&vector[n-1])<0)
{
	if ((n+1-principio) > msize)
	{   
		posfin=principio;
		msize=(n-principio+1);
	}

}

*ndevolucion=msize;

/* Bucle de copia del vector */
for (j=0;j<msize;j++)
{
	devolucion[j]=vector[posfin+j];
}
}


int main(){
	int i;
	float c=4,d=9;
	int n1=5,tn1,vector1[]={-1,-1,-2,2,-4},vuelta1[n1];
	int n2=6,tn2,vector2[]={-1,2,3,1,2,-3},vuelta2[n2];
	printf("%d\n",A(3,1)); /* prueba de ackerman */
	divisionReal(4,1,&c,&d); /* prueba de divisionReal */
	printf("%e,%e\n",c,d);
	divisionReal(3,0,&c,&d); /* prueba de divisionReal */
	printf("%e,%e\n",c,d);
	secuenciaNegativos(vector1,n1,vuelta1,&tn1); /* prueba secuenciaNegativos */ 
	for (i=0;i<tn1;i++){printf("%d",vuelta1[i]);}

	secuenciaNegativos(vector2,n2,vuelta2,&tn2); /* prueba secuenciaNegativos */
	for (i=0;i<tn2;i++){printf("%d",vuelta2[i]);}
	printf("\n");
	return 0;
}



