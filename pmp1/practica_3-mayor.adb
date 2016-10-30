separate (Practica_3)

function Mayor(V:Vector) return TMayor is
   Temp: Integer; --Variable temporal donde guardo el mayor
   Resultado: Tmayor; --Variable tmayor a devolver

begin

   -------------------------------------------------------------------
   -- Antes de comenzar el bucle, la variable a devolver tiene el   --
   -- primer valor tanto en posicion como en elemento, no puedo     --
   -- garantizar que el primero no sea el mayor                     --
   -------------------------------------------------------------------

   -- la variable temporal tambien contriene el primer valor
   -- porque es la mayor en este momento

   Temp := V'First;
   Resultado.Elemento:=V(V'First);
   Resultado.Posi:=Temp;
   put(Temp);
   --Comienzo el bucle en el segundo elemento..hasta el final del vector.
   for J in V'First+1..V'Last loop

      -- y si encuentro un resultado mayor del que tenia
      -- Lo asigno en la variable resultado.elemento,
      -- y su posicion en resultado.posi

      if V(J) > Temp then
         Resultado.Elemento := V(J);
         Resultado.Posi := j;
         Temp := V(J); --Y la variable temporal obtiene un nuevo valor
      end if;

   end loop;

   return Resultado; --Devuelvo lo que he obtenido en el bucle
end Mayor;
