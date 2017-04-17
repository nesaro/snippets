package body Colas.Rest is

   -- Procedimiento insertar:
   -- A�ade a la siguiente posici�n un nuevo elemento
   -- Comprueba que no estamos en el limite del vector
   procedure Insertar(C: in out CRestringida; E: in TElemento) is
   begin
      if C.Num_elem < MAX_SIZE then
         C.Num_Elem:=C.Num_Elem+1;
         C.Elementos(C.Num_Elem):=E;
      else
         raise E_cola_llena;
      end if;
   end Insertar;

   -- Como insertar a�ade elementos por el final,
   -- Extraer debe quitarlos por el principio.
   -- Asi que para mantener el primero como tal,
   -- hago rotar los elementos del vector a la izq.
   procedure Extraer(C: in out CRestringida) is
   begin
      if C.Num_elem=0 then
         raise E_Cola_vacia; --debe contener algo
      else
         for I in 1..(C.Num_Elem -1) loop
            C.Elementos(I):=C.Elementos(I+1);
         end loop;
         C.Num_elem:=C.Num_elem-1;
      end if;
   end Extraer;

   function Es_Vac�a(C: in CRestringida) return Boolean is
   begin
      if C.Num_Elem=0 then
         return True;
      end if;
      return False;
   end Es_Vac�a;

   -- Muestro siempre el primer elemento
   function Examinar(C: in CRestringida) return TElemento is
   begin
      return C.Elementos(1);
   end Examinar;

   -- Simplemente devuelvo el contenido del campo num_elem
   function Tama�o(C: in CRestringida) return Natural is
   begin
      return C.Num_Elem;
   end Tama�o;

end Colas.Rest;
