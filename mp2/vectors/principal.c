#include <stdio.h>
#include "obtenciondatos.h"

int main(){
	int nc_inv[6],nm_inv[6],i;
	float nm_ale[6],nc_ale[6],t_inv[6],t_ale[6];
	int tam[]={1000,2000,4000,8000,16000,32000};
	/*obteniendo datos del primer metodo*/
	obtencionDatos1(tam,6,nc_inv,nm_inv,t_inv,nc_ale,nm_ale,t_ale);
	printf("Metodo1\n");
	printf("Vector inversamente ordenado -      Vector aleatorio\n");
	printf("T,     tiempo    Comp      Movi  -   tiempo    Comp      Movi  \n");
	for (i=0;i<6;i++) printf("%5d %5.2f %8d %10d  -  %5.2f %8.2f %10.2f\n",tam[i],t_inv[i],nc_inv[i],nm_inv[i],t_ale[i],nc_ale[i],nm_ale[i]);
	printf("\nMetodo2\n");
	/*obteniendo datos del segundo metodo*/
	obtencionDatos2(tam,6,nc_inv,nm_inv,t_inv,nc_ale,nm_ale,t_ale);
	printf("T,     tiempo    Comp      Movi  -   tiempo    Comp      Movi  \n");
	for (i=0;i<6;i++) printf("%5d %5.2f %9d %10d  -  %5.2f %9.2f %10.2f\n",tam[i],t_inv[i],nc_inv[i],nm_inv[i],t_ale[i],nc_ale[i],nm_ale[i]);
	return 0;
}
