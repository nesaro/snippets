separate (Practica6)
procedure Extraer (L: in out Lista; V: in Integer) is
   Temp,Tanterior,Tsiguiente,Final,Segundo:Pnodo;
   Cambiado: Boolean;
begin

   -- Cambiado controla si ya he hecho alguna extracción para evitar entrar en
   -- los siguientes bloques

   Cambiado:=False;
   Final:=L.Fin;
   Temp:=L.Inicio;
   Segundo:=Temp.Siguiente;

   -- Bloque de comprobacion del primero, si vale lo mismo que V, el segundo
   --sera el nuevo primero

   if (Temp/=null) then
      if Temp.Info = V then
         Temp:=L.Inicio.Siguiente;
         Liberar(L.Inicio);
         L.Inicio:=Temp;
         L.Numelem:=L.Numelem-1;
         Cambiado:=True;
      end if;
   end if;
   --Bloque de comprobacion de intermedios, recorre desde el segundo hasta el ultimo
   --(sin entrar en el).

   Temp:=segundo;
   if (Temp/=null and not cambiado) then
      while (Temp/=final and L.Numelem>2) loop
         if (Temp.Info=V) then
            Tanterior:=Temp.Anterior;
            Tsiguiente:=Temp.Siguiente;
            Tanterior.Siguiente:=Tsiguiente;
            Tsiguiente.Anterior:=Tanterior;
            Liberar(Temp);
            Temp:=Final;
            L.Numelem:=L.Numelem-1;
            Cambiado:=True;
         else
            Temp:=Temp.Siguiente;
         end if;
      end loop;


      --Bloque de comprobacion del final. Si he llegado hasta aqui
      -- y el valor del elemento coincide, hago las transformaciones
      -- pertinentes para que el elemento anterior sea el nuevo ultimo

      if(L.Numelem>1 and not cambiado) then
         if(L.Fin.Info=V) then
            Temp:=L.Fin.Anterior;
            Liberar(L.Fin);
            L.Fin:=Temp;
            L.Numelem:=L.Numelem-1;
         end if;
      end if;
   end if;
   return;
end;
