separate (Practica_3)

function Suma_Filas(M:Matriz) return Vector is
   Temp: Integer; --Variable temporal para ir asignando la suma
   Vec: Vector(M'First(2)..M'Last(2)); --Vector donde guardo el resultado

begin
   ------------------------------------------------
   -- El programa hace un recorrido de la matriz --
   -- Recorre todas las columnas sumando todas   --
   -- sus filas.                                 --
   ------------------------------------------------

   for I in M'First(2)..M'Last(2) loop --Bucle de recorrido de columnas

      --Variable temporal donde guardo la suma de las filas
      --Vale 0 al comienzo de cada columna
      Temp:=0;

      for J in M'First(1)..M'Last(1) loop --Bucle de recorrido de filas
         Temp:=Temp+M(J,I); --Voy sumando el valor de cada fila
      end loop; -- Ya he recorrido todas las filas


       ------------------------------------------------------------
      -- Control de excepcion, si la variable temporal excede los --
      -- limites del numero_corto lanzara error_suma. Es posible  --
      -- hacer la asignacion directa al vector y evaluar la suma  --
      -- directamente, pero entiendo que es mas optimo hacer las  --
      -- asignaciones temporales en un entero y asignar el valor  --
      -- al vector (y comprobar su valor) solo una vez.           --
       ------------------------------------------------------------

      if (Temp > Numero_Corto'Last or Temp < Numero_Corto'First ) then
         raise Error_Suma;
      end if;
      --Si no ha habido error se realiza la asignacion al vector
      --(Solo una vez por Columna)
      Vec(I):=Temp;
   end loop;
   return Vec; --Una vez acabadas todas las columnas, devuelvo el vector

end Suma_Filas;
