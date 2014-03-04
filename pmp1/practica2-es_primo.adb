separate (Practica2)
function Es_Primo(N: in Natural) return Boolean is
   Temp: Boolean;
   Mitad,Contador: Natural;
begin
   Temp := True; -- Es primo por defecto.
   Mitad := N/2; -- Fracción de enteros, devuelve el valor absoludo del cociente.
   Mitad := Mitad+1; -- Sumo uno para que supere la mitad. No afecta ni al 1 ni al 2 porque no entran en el bucle
   Contador := 2;
   if (N = 0) then
      Temp := False; -- 0 es un caso especial. No es primo.
   end if;
   while ((Contador < Mitad) and (Temp=True)) loop --Mientras contador sea menor que mitad y no se haya detectado divisor
      if (N rem Contador)=0 then
         Temp := False; -- Hemos detectado un divisor. Ya no es primo!
      end if;
      Contador := Contador+1; --Subir 1 al contador
   end loop;
   return Temp; --Una vez terminado el bucle devolvemos el valor de temp.
end Es_Primo;
