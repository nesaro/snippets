separate (Practica6)
procedure Insertar(L: in out Lista; V: in Integer) is
   Direccionu,Direccion1:Pnodo; --Punteros auxiliares
begin

   --El objetivo de este procedimiento es insertar elementos en la lista enlazada
   --por el final y haciendo que el paremetro L.numelem sea coherente.

   --Asi que barajamos 3 posibles casos...

   --Si el numero de elementos es mayor que 1, significa que el primero y el
   --ultimo ya existian de antemano, asi que solo tengo que añadirle un siguiente
   --al ultimo elemento y convertir el nuevo elemento en ultimo de la lista

   if (L.Numelem>1) then
      Direccionu:=L.Fin;
      Direccion1:=Crear(V);
      Direccion1.Anterior:=Direccionu;
      Direccionu.Siguiente:=Direccion1;
      L.Fin:=Direccion1;
      L.Numelem:=L.Numelem+1;
   end if;

   --Si el numero de elementos es igual a 1, significa que existe el primero pero no
   --el ultimo, asi que creo un nuevo elemento que pasa a ser el siguiente del primero
   --y a su vez el ultimo de la lista

   if (L.Numelem=1) then
      Direccionu:=L.Inicio;
      Direccion1:=Crear(V);
      Direccionu.Siguiente:=Direccion1;
      Direccion1.Anterior:=Direccionu;
      L.Fin:=Direccion1;
      L.Numelem:=2;
   end if;

   --Si el numero de elementos es 0,creare uno nuevo y simplemente lo asignare como primero
   if (L.Numelem=0) then
      Direccion1:=Crear(V);
      L.Inicio:=Direccion1;
      L.Numelem:=1;
   end if;
   return;

exception
   -- No hacemos nada en caso de que se agote la memoria
   when Storage_Error =>
      Put_Line("Agotada memoria disponible");
      return;

end;
