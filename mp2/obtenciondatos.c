#include "obtenciondatos.h"
#include "compvect.h"
#include "metodo1.h"
#include "metodo2.h"

void obtencionDatos1(int tam[], int n, int nc_inv[], int nm_inv[], float t_inv[], float nc_ale[], float nm_ale[], float t_ale[])
{
	float tnc,tnm,ttie,tie;
	int i,j,nc=0,nm=0;
	int *vgenerado;
	/* Bucle de prueba para cada tamaño */
	for(i=0;i<n;i++)
	{
		tnc=0;tnm=0;ttie=0;
		vgenerado=(int*)malloc(sizeof(int)*tam[i]);
		/* Bucle para generar 10 pruebas aleatorias independientes */
		for(j=0;j<10;j++)
		{
			inicializaVector(vgenerado,tam[i],2);
			metodo1(vgenerado,tam[i],&nc,&nm,&tie);
			tnc+=nc;
			tnm+=nm;
			ttie+=tie;
			compruebaVector(vgenerado,tam[i]);
		}
		tnc/=10;
		tnm/=10;
		ttie/=10;
		/*Asigno la media de los resultados*/
		nc_ale[i]=(int)tnc;
		nm_ale[i]=(float)tnm;
		t_ale[i]=(float)ttie;
		/*Ahora calculo los datos para el vector de orden invertido */
		inicializaVector(vgenerado,tam[i],1);
		metodo1(vgenerado,tam[i],&nc,&nm,&ttie);
		compruebaVector(vgenerado,tam[i]);
		nm_inv[i]=nm;
		nc_inv[i]=nc;
		t_inv[i]=ttie;
		free(vgenerado); /*Libero el espacio guardado*/
	}

}
void obtencionDatos2(int tam[], int n, int nc_inv[], int nm_inv[], float t_inv[], float nc_ale[], float nm_ale[], float t_ale[])
{
	float tnc,tnm,ttie,tie;
	int i,j,nc=0,nm=0;
	int *vgenerado;
	/* Bucle de prueba para cada tamaño */
	for(i=0;i<n;i++)
	{
		tnc=0;tnm=0;ttie=0;
		vgenerado=(int*)malloc(sizeof(int)*tam[i]);
		/* Bucle para generar 10 pruebas aleatorias independientes */
		for(j=0;j<10;j++)
		{
			inicializaVector(vgenerado,tam[i],2);
			metodo2(vgenerado,tam[i],&nc,&nm,&tie);
			tnc+=nc;
			tnm+=nm;
			ttie+=tie;
			compruebaVector(vgenerado,tam[i]);
		}
		tnc/=10;
		tnm/=10;
		ttie/=10;
		/*Asigno la media de los resultados*/
		nc_ale[i]=(int)tnc;
		nm_ale[i]=(float)tnm;
		t_ale[i]=(float)ttie;
		/*Ahora calculo los datos para el vector de orden invertido */
		inicializaVector(vgenerado,tam[i],1);
		metodo2(vgenerado,tam[i],&nc,&nm,&ttie);
		compruebaVector(vgenerado,tam[i]);
		nm_inv[i]=nm;
		nc_inv[i]=nc;
		t_inv[i]=ttie;
		free(vgenerado); /*Libero el espacio guardado*/
	}

}
