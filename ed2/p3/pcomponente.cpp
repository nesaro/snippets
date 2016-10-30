#include <iostream>
   using namespace std;
#include "pcomponente.h"
#include "componentes.h"

//Hace la prueba y muestra mensajes de error en caso de fallo
   static void pruebaComponenteInterno(const Componente &objeto, string resARistra, int resNcaracteres, int resNpalabras,
                     string mensaje){
      string saRistra=objeto.aRistra();
      int sncaracteres=objeto.ncaracteres();
      int snpalabras=objeto.npalabras();
      if(saRistra != resARistra)
         cerr << mensaje << ": Error en aRistra() da \"" <<saRistra << "\" y debe dar \"" << resARistra << "\"" << endl;
      if(sncaracteres != resNcaracteres)
         cerr << mensaje << ": Error en ncaracteres() da " <<sncaracteres << " y debe dar " << resNcaracteres << endl;
      if(snpalabras != resNpalabras)
         cerr << mensaje << ": Error en npalabras() da " <<snpalabras << " y debe dar " << resNpalabras << endl;
   }
  //Comprueba la interfaz pública de un Componente.
  //Se le pasa el objeto a probar y lo que debe devolver en cada caso.
  //Se pasa un texto a mostrar en caso de error.
  //Prueba, además, la copia de un objeto
   void pruebaComponente(const Componente &objeto, string resARistra, int resNcaracteres, int resNpalabras,
                     string mensaje){
      pruebaComponenteInterno(objeto,resARistra,resNcaracteres,resNpalabras,mensaje);
      Componente *c=objeto.copia();
      pruebaComponenteInterno(*c,resARistra,resNcaracteres,resNpalabras,"Copia de "+mensaje);
      delete c;
   }
