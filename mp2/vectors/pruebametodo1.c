#include <stdio.h>
#include "metodo1.h"
#include "metodo2.h"

int main(){
	int vector[7];
	int vector2[7];
	int pepe1,pepe2,i;
	float pepe3;
	vector[0]=1;
	vector[1]=2;
	vector[2]=13;
	vector[3]=4;
	vector[4]=25;
	vector[5]=6;
	vector[6]=17;
	vector[7]=18;
	vector2[0]=1;
	vector2[1]=2;
	vector2[2]=13;
	vector2[3]=4;
	vector2[4]=25;
	vector2[5]=6;
	vector2[6]=17;
	vector2[7]=18;
	metodo2(vector,7,&pepe1,&pepe2,&pepe3);
	for (i=0;i<=7;i++)
	{
		printf ("%d\n",vector[i]);
	}
	return 0;
}
