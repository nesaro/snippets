with Ada.Strings.Unbounded,Text_IO;
use Ada.Strings.Unbounded,Text_IO;
package body conjunto_de_palabras is

function ver(D: árbol) return Unbounded_string ;
		-- La funcion insertar llama a la funcion recursiva preparar para actualizar el contenido 
		-- del diccionario.
Procedure Insertar(D: in out TDiccionario; S: in  Unbounded_string) is
		b:Unbounded_string;
		num,tama:integer;
begin
		b:=S;
		tama:=Length(S);
		append(b,to_unbounded_string("*")); -- Añado el * a la palabra
		num:=resta(D.contenido,b,1); -- Previamente compruebo si la palabra ya esta en el diccionario
		if (num /= 0) then
				-- Si no esta, llamo a la función recursiva y aumento los valores de caracteres y palabras
				D.contenido:=preparar(D.contenido,b,1); 
				num:=num-1;
				D.num_car:=D.num_car+tama-num;
				D.num_pal:=D.num_pal+1;
		end if;
end insertar;

-- Está acude a la función recursiva resta para saber
-- si una palabra existe
function está(D: in TDiccionario; S: in Unbounded_string) return boolean is
		palabra:Unbounded_string;
		temp:boolean; -- Estado a devolver
begin
		temp:=false;
		palabra:=S;
		append(palabra,to_unbounded_string("*")); -- Añado el '*' a la palabra
		if (resta(D.contenido,palabra,1) = 0) then 
				-- Si la función recursiva resta devuelve 0, la palabra está y devuelvo verdadero.
				temp:=true;
		end if;
	    put(to_string(ver(D.contenido)));
		return temp;
end está;

-- La función palabras se limita a devolver el contenido del campo num_pal del diccionario
function palabras (D: in TDiccionario) return natural is
begin
		return D.num_pal;
end palabras;

-- La función caracteres se limita a devolver el contenido del campo num_car del diccionario
function caracteres (D: in TDiccionario) return natural is
begin
		return D.num_car;
end caracteres;

-- La función resta (recursivo-esta) va recorriendo el árbol, devolviendo el número
-- de caracteres aprovechables en el arbol (+1) para esa palabra en caso de que 
-- no este, y devolviendo 0 en caso de que si este. S es la cadena, y n es el numero
-- de caracteres aprovechados detectados previamente.

function resta(D: in Árbol; s:Unbounded_string; n:integer) return integer is

		caracter: Character;
begin
		-- Si es vacia la raíz actual, parte de la palabra falta y devuelvo cuanto he ahorrado
		if Es_Vacío(D) then
				return n;
		else
				caracter:=to_string(s)(1);
				if (Raíz(D)='*' and (Length(S)=1)) then
						return 0; --Condicion de salida,la palabra si está, devuelvo 0
				else
						if (Raíz(D)=caracter) then
								-- El caracter coincide, llamo a resta por la izquierda para el 
								-- siguiente caracter y sumo 1 a los ahorrados
								return resta(izquierdo(D),to_unbounded_string(Slice(s,2,Length(S))),n+1);
						else
								-- El caracter no coincide, comparo...
								if (not (Es_Vacío(derecho(D)))) then
										if (Raíz(derecho(D)) > caracter) then
												-- Si el caracter es menor que lo que tengo a la derecha,
												-- ninguna rama más a la derecha va a coincidir,
												-- devuelvo lo ahorrado
												return n;
										else
												-- sigo mirando a la derecha, manteniendo la cantidad ahorrada
												return resta(derecho(D),s,n);
										end if;
								else
										-- No hay nada a la derecha, no puedo continuar, devuelvo lo ahorrado
										return n;
								end if;
						end if;
				end if;
		end if;
end resta;

-- La función preparar va recorriendo las ramas del árbol, insertando caracteres segun el criterio
-- establecido por el arbol

function preparar(D: Árbol; s:Unbounded_string; n: integer) return Árbol is
		temp,temp2,arbolnulo: Árbol;
		caracter:Character; -- El caracter de la cadena a evaluar
		siguiente:integer; -- n+1, hace el codigo mas legible
begin
		siguiente:=n+1;
		caracter:=(to_string(s)(n));
		-- Estamos ante el caracter de cierre de palabra.
		if (caracter='*') then
				-- Si no hay rama donde guardarlo, simplemente la creo.
				if Es_Vacío(d) then
						temp:=Crear(caracter,arbolnulo,arbolnulo);
				else
						-- Si la rama existe, compruebo que el caracter que habia es mayor que *
						if (Raíz(D)>caracter) then
								-- Si es mayor, guardo el * en la izquierda y el contenido anterior a la derecha
								temp2:=Crear(Raíz(D),izquierdo(D),derecho(D));
								temp:=modificar(D,caracter,arbolnulo,temp2);
						else
								-- Si es menor, el * se guardaria en la siguiente posicion disponible a la derecha.
								temp:=modificar(D,Raíz(D),izquierdo(D),preparar(derecho(D),s,n));
						end if;	
				end if;

		else
				-- Caracter diferente de *:
				if Es_Vacío(D) then
						-- Si ya no existe más ramas, las voy creando por la izq. y avanzando en la palabra
						temp:=Crear(caracter,preparar(arbolnulo,s,siguiente),arbolnulo);
				else
						-- Si existe la rama, y ademas el caracter coincide, continuo por la rama izq. con el i
						-- siguiente caracter, manteniendo la derecha como estaba
						if(Raíz(D)=caracter) then
								temp:=modificar(D,caracter,preparar(izquierdo(D),s,siguiente),derecho(D));

								-- Si el caracter no coincide, los comparo para mantener el orden.
						else
								-- Si el caracter es menor que el contenido, continuo por la izquierda y i
								-- dejo una copia de la rama actual a  la derecha.
								if (Raíz(D)>caracter) then
										temp2:=Crear(Raíz(D),izquierdo(D),derecho(D)); -- La copia es necesaria
										temp:=modificar(D,caracter,preparar(arbolnulo,s,siguiente),temp2);
								else
										-- Si el caracter es mayor, le sigo buscando un hueco por la derecha
										temp:=modificar(D,Raíz(D),izquierdo(D),preparar(derecho(D),s,n));
								end if;	
						end if;
				end if;

		end if;
		return temp;
exception
		when Storage_error => raise E_Diccionario_Lleno;

end preparar;

function ver(D: árbol) return Unbounded_string is
P:Unbounded_string;
J:string(1..1);
begin

	if (Es_Vacío(D)) then
    return To_Unbounded_String("");
else
J(1):=Raíz(D);
Append(P,To_Unbounded_String(J));
Append(P,To_Unbounded_String("{"));
Append(P,ver(izquierdo(D)));
Append(P,To_Unbounded_String(","));
Append(P,ver(derecho(D)));
Append(P,To_Unbounded_String("}"));
return P;
end if;

end ver;

end conjunto_de_palabras;

