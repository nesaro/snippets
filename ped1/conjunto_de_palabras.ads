with �rbol_bin,Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
package conjunto_de_palabras is
		type TDiccionario is private;

		--Procedimiento de insercion de palabras
		Procedure Insertar(D: in out TDiccionario; S: in  Unbounded_string);
		-- Funci�n para comprobar si una palabra pertenece a un arbol
		function est�(D: in TDiccionario; S: in Unbounded_string) return boolean;
		-- Funci�n que devuelve el n�mero de palabras almacenadas
		function palabras (D: in TDiccionario) return natural;
		-- Funci�n que devuelve el n�mero de caracteres almacenados
		function caracteres (D: in TDiccionario) return natural;
		-- Excepci�n para controlar la imposibilidad de crear nuevas ramas
		E_diccionario_lleno: exception;
		private

		package arbolcar is new �rbol_bin(character); -- Creo un paquete instanciando a �rbol_bin con caracteres
		use arbolcar;
		type TDiccionario is record -- El tipo diccionario es un record con 3 elementos
				contenido: �rbol; -- Un arbol de caracteres
				num_pal,num_car: integer :=0; -- Dos enteros que controlan el numero de palabras y caracteres
		end record;
		-- Funci�n recursiva de apoyo para la inserci�n
		function preparar(D: in  �rbol; s:Unbounded_string; n:integer) return �rbol;
		-- Funci�n recursiva de apoyo para est�
		function resta(D: in �rbol; s:Unbounded_string;n:integer) return integer;
end conjunto_de_palabras;
