--Cláusula de contexto con las librerías básicas de E/S.
with Text_Io, Ada.Integer_Text_IO;
use Text_Io, Ada.Integer_Text_IO;

--Aquí empieza el procedimiento principal del programa.
procedure Practica1 is
   --Aquí van las declaraciones del algoritmo.
   Entrada: Integer;
   Contador: Integer;
begin
   --aquí van las sentencias ejecutables del algoritmo.

   Text_IO.Put("Introduce el numero");
   new_line;
   Get(Entrada);

   if entrada =0 then
      Text_IO.Put("CERO");
      new_line;
   else
      if Entrada > 0 then
         Text_IO.Put("Numero mayor que 0, contando en positivo");
         New_Line;
         Contador := 1;
         for Contador in 1..Entrada loop
    Put(Contador);
    New_line;
         end loop;
      else

         Text_IO.Put("Numero menor que 0, contando en negativo");
         New_line;
         Contador := -1;
         for Contador in reverse Entrada..-1 loop
            Put(Contador);
            New_line;
         end loop;
      end if;
   end if;
end Practica1;
