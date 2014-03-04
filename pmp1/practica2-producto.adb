separate (Practica2)
procedure Producto(X: in integer; Y: out Integer) is
begin
   if X = 0 then
      Y := X; --si es 0, Y es devuelto con el mismo valor: 0
      return;
   else
      if X > 0 then -- si es mayor que 0, lo multiplico por si mismo tantas veces como sea necesaria
         Y :=1;
         for K in 2..X loop
            Y := Y*K; -- Voy multiplicando por el resultado anterior hasta que llego a X en el loop
         end loop;
      else -- si es menor que 0, multiplico desde -1 en adelante, haciendo el loop inverso
         Y :=-1;
         for K in reverse X..-2 loop -- Igual que con los positivos pero haciendo el recorrido inverso
            Y := Y*K;
         end loop;
      end if;
   end if;
   return; -- volver al programa principal con la y asignada

end Producto;
