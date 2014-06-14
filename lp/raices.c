#include <stdio.h>
#include <math.h>

/* Declaración de funciones */

int raices(float (*f)(float),float linf,  float lsup, float delta, float soluciones[]);
float resuelve (float (*f)(float),float linf,float lsup,float delta);
float f1(float);
float f2(float);
float f3(float);
float f4(float);

/* Main */
int main(){
	int nres,i=0,opcion,li,ls;
	float soluciones[10],lsup,linf,delta;
	printf("Bienvenido al buscador de soluciones\n");
	printf("¿Qué ecuación desea utilizar?\n1.x^2 + x -12 \n2.x^2-3x+2 \n3.x^2-2x \n4.sen(x)/(x+11) \n");
	scanf("%d",&opcion);
	printf("\n¿Limite inferior?\n");
	scanf("%d",&li);
	printf("\n¿Limite superior?\n");
	scanf("%d",&ls);
	printf("\n¿Precisión?\n");
	scanf("%f",&delta);
	linf=li;
	lsup=ls;
	switch(opcion){
		case 1:
			nres=raices(f1,linf,lsup,delta,soluciones);
			break;
		case 2:
			nres=raices(f2,linf,lsup,delta,soluciones);
			break;
		case 3:
			nres=raices(f3,linf,lsup,delta,soluciones);
			break;
		case 4:
			nres=raices(f4,linf,lsup,delta,soluciones);
			break;
	}
	printf("Número de soluciones encontradas: %d \n",nres);
	printf("Las soluciones son:\n");
	for (i=0;i<nres;i++)
	{
		printf("%f\n",soluciones[i]);
	}
	return 0;
}


int raices(float (*f)(float),float linf,  float lsup, float delta, float soluciones[])
{
	float tintervalo=(lsup-linf)*(delta*100); /*Definimos el tamaño del intervalo */
	int i=0;
	int nresultado=0;

	for (i=0;i<(1/(100*delta));i++) /* Y para cada intervalo */
	{
		float linferior=linf+(tintervalo*i);
		float lsuperior=linferior+tintervalo;
		if (f(linferior)==0)
		{
			soluciones[nresultado++]=linferior;
			linferior=linferior+delta; /*Buscamos dentro del intervao que queda */
		}
		if (f(lsuperior)==0)
		{
			soluciones[nresultado++]=lsuperior;
			i=i+1; //el siguiente limite inferior repetiria el resultado
			lsuperior=lsuperior-delta; /*Buscamos dentro del intervalo que queda */
		}
		if (f(linferior)*f(lsuperior)<0)
		{
			/* LLamamos a la funcion resuelve,con la garantia de que exite una raiz */
			soluciones[nresultado++]=resuelve(f,linferior,lsuperior,delta);
		}

	}
	return nresultado;
}	

/* Resuelve: utiliza el método de la bisección sobre un intervalo */
float resuelve (float (*f)(float),float linf,float lsup,float delta)
{
	float mitad=(lsup+linf)/2; 
	if (f(lsup)==0) /*Hemos encontrado un 0 en un extremo */
		return lsup;
	if (f(linf)==0) /*Hemos encontrado un 0 en el otro */
		return linf;
	if (f(mitad)==0)/* Hemos encontrado un 0 en la mitad */
		return mitad;
	if ((lsup-linf)<delta) /*El intervalo es demasiado pequeño */
		return mitad;
	if (f(linf)*f(mitad)<0) /*Seguimos llamando a la izquierda o derecha */
		return resuelve (f,linf,mitad,delta);
	return resuelve (f,mitad,lsup,delta);
}

float f1(float x) { return x*x+x-12; }
float f2(float x) { return x*x-3*x+2; }
float f3(float x) { return x*x-2*x; }
float f4(float x) { return sin(x)/(x+11); }

