with ada.strings.unbounded;
use ada.strings.unbounded;
package conjunto_de_palabras.adicional is
	-- Procedimiento de extraccion
	procedure extraer(D: in out tdiccionario; S: in unbounded_string);
	-- Funcion de igualdad
	function "="(D1,D2:tdiccionario) return boolean;
end conjunto_de_palabras.adicional;
	
