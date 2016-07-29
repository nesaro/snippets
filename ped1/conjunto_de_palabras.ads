with árbol_bin,Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
package conjunto_de_palabras is
		type TDiccionario is private;

		--Procedimiento de insercion de palabras
		Procedure Insertar(D: in out TDiccionario; S: in  Unbounded_string);
		-- Función para comprobar si una palabra pertenece a un arbol
		function está(D: in TDiccionario; S: in Unbounded_string) return boolean;
		-- Función que devuelve el número de palabras almacenadas
		function palabras (D: in TDiccionario) return natural;
		-- Función que devuelve el número de caracteres almacenados
		function caracteres (D: in TDiccionario) return natural;
		-- Excepción para controlar la imposibilidad de crear nuevas ramas
		E_diccionario_lleno: exception;
		private

		package arbolcar is new árbol_bin(character); -- Creo un paquete instanciando a árbol_bin con caracteres
		use arbolcar;
		type TDiccionario is record -- El tipo diccionario es un record con 3 elementos
				contenido: Árbol; -- Un arbol de caracteres
				num_pal,num_car: integer :=0; -- Dos enteros que controlan el numero de palabras y caracteres
		end record;
		-- Función recursiva de apoyo para la inserción
		function preparar(D: in  Árbol; s:Unbounded_string; n:integer) return Árbol;
		-- Función recursiva de apoyo para está
		function resta(D: in Árbol; s:Unbounded_string;n:integer) return integer;
end conjunto_de_palabras;
