separate (Practica6)
function  Valores (L: in Lista) return Vector      is
   Vectornulo: Vector(1..0);
   Vectoralmacen: Vector(1..L.numelem);
   Temp: Pnodo;
   Lista_Vacia: exception;
   -- La funcion valores simplemente devuelve un vector con el
   -- Contenido de la lista enlazada

begin

   Temp:=L.Inicio;

   if (L.Numelem = 0) then
      raise Lista_Vacia; --la excepcion pedida
   end if;

   --Bucle principal, recorro todos los elementos guardando el valor
   --en cada posicion del vector

   for i in 1..L.Numelem loop
      Vectoralmacen(I):=Temp.Info;
      Temp:=Temp.Siguiente;
   end loop;

   -- devolver lo cosechado

   return Vectoralmacen;

end;
