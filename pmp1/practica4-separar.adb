with Ada.Strings.Fixed; --Necesario Para Hacer Index con strings fijas
use Ada.Strings.Fixed;
separate (Practica4)

procedure Separar(R_Total: in  Unbounded_String;
                  R_Letra: out Unbounded_String;
                  R_numer: out Unbounded_String) is
   Numeros: String(1..11);
   Letras: String(1..53);
   Caracter: String(1..1); -- Cadena donde guardo el caracter a evaluar

begin

   -- Numeros contiene todos los caracteres numéricos y el espacio,
   -- Letras contiene todos los caracteres alfabéticos y el espacio.

   Numeros := " 0123456789";
   Letras := " aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ";

   -- Bucle principal del procedimiento:
   -- Recorro toda la cadena de entrada evaluando carácter a carácter

   for I in 1..Length(R_Total) loop
      -- Obtencion del caracter por medio de un slice
      Caracter := Slice(R_Total,I,I);
      -- Si el caracter esta en la cadena letras, lo agrego
      -- a la cadena de salida R_letra
      if (Index(Letras,Caracter) /= 0) then
         Append(R_Letra,Caracter);
      end if;
      -- Si el caracter esta en la cadena numeros, lo agrego
      -- a la cadena de salida R_numer
      if (Index(Numeros,Caracter) /= 0) then
         Append(R_numer,Caracter);
      end if;
   end loop; --Fin del bucle

end Separar; --Vuelta al programa principal
