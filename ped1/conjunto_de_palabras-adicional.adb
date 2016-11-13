package body conjunto_de_palabras.adicional is
	-- devolucion es un record hecho para que la funcion recursiva devuelva varios parametros
	type devolucion is record
		Estado: boolean;
		ahorro: natural:=0;
	end record;
	function rextraer(D: árbol; S: unbounded_string) return devolucion;
	function rcompro(D1,d2:árbol) return boolean;

	procedure extraer(D: in out tdiccionario; S: in unbounded_string) is
		M: devolucion; --record donde guardo los caracteres que he ahorrado
		J: unbounded_string; --cadena auxiliar
	begin
		J:=S;
		append(J,to_unbounded_string("*"));
		if (está(D,S)) then
			if(palabras(d)=1) then
				-- Si solo hay una palabra en el arbol, y es la que quiero borrar, vacio directamente el arbol	
				D.num_pal:=0;
				D.num_car:=0;
				vaciar(D.contenido);
			else
				-- Si hay mas palabras, llamo a la funcion recursiva
				M:=rextraer(D.contenido,J);
				D.num_car:=D.num_car-M.ahorro;
				D.num_pal:=D.num_pal-1;
			end if;
		end if;
	end extraer;

	function "="(D1,D2:tdiccionario) return boolean is
	begin
		-- Primero compruebo si coinciden los campos de caracteres y palabras
		if((palabras(D1) = palabras(d2)) and (caracteres(D1)=caracteres(D2))) then
			--llamo a la recursividad para comprobar si son iguales
			return rcompro(D1.contenido,D2.contenido);
		else
			return false;
		end if;
	end "=";

	-- Funcion recursiva de extraccion
	function rextraer(D: árbol; S :unbounded_string) return devolucion is
		Temp1,temp2: árbol;
		C: devolucion;
	begin
		if(Raíz(D)='*' and Length(S)=1) then

			if (not es_vacío(derecho(D))) then --se cumple la condicion, la derecha tiene el control
				C.estado:=false;
				-- sustituir por la derecha
				Temp1:=D;
				temp2:=derecho(D);
				temp1:=modificar(temp1,raíz(derecho(D)),izquierdo(derecho(D)),derecho(derecho(D)));
				temp2:=modificar(temp2,raíz(temp2),vacío,vacío);
				vaciar(temp2);
			else
				C.estado:=true;
			end if;
			C.ahorro:=0;
			return C;
		else
			if(Raíz(D)=to_string(S)(1)) then --el caracter coincide	
				C:=rextraer(izquierdo(D),to_unbounded_string(Slice(S,2,Length(S))));
				-- C.estado a verdadero significa que aun no he encontrado por donde cortar
				if C.estado=true then
					if (not es_vacío(derecho(D))) then 
						-- Esta es una condicion, hay algo que no pertenece a nuestra palabra a la derecha
						C.estado:=false; -- ya no corto más
						Temp1:=D;
						temp2:=derecho(D);
						-- copio el contenido del derecho
						temp1:=modificar(temp1,raíz(derecho(D)),izquierdo(derecho(D)),derecho(derecho(D))); 
						-- Dejo el derecho sin hijos para controlar su destrucción
						temp2:=modificar(temp2,raíz(temp2),vacío,vacío);
						vaciar(temp2);
					end if;
					C.ahorro:=C.ahorro+1;
				end if;
				return c;
			else -- el caracter no coincide
				C:=rextraer(derecho(D),S);
				if C.estado=true then
					-- La otra condicion: si aun no he encontrado por donde cortar, y me encuentro con algo que no
					-- pertenece, significa que el resto de la palabra cuelga por la derecha
					C.estado:=false; --ya no corto más
					Temp1:=D;
					temp2:=derecho(temp1);
					Vaciar(temp2);
					Temp1:=modificar(Temp1,raíz(D),izquierdo(D),vacío);
				end if;
				return C;
			end if;
		end if;
	end rextraer;

	-- Funcion recursiva de comprobacion
	function rcompro(D1,d2:árbol) return boolean is
		temp:boolean;
	begin
		-- Las raices son iguales
		if (es_vacío(D1) and es_vacío(D2)) then
			return true;
		else
			if (es_vacío(D1) or es_vacío(D2)) then
				return false;
			end if;
		end if;
		if (raíz(D1)=raíz(D2)) then
			-- Comprobaciones del estado de los hijos
			if (es_vacío(izquierdo(D1))) then
				if (es_vacío (izquierdo(D2))) then
					return true;
				else 
					return false;
				end if;
			end if;
			if (es_vacío (izquierdo(D2))) then
				return false;
			end if;
			if (es_vacío(derecho(D1))) then
				if (es_vacío (derecho(D2))) then
					return true;
				else
					return false;
				end if;
			end if;
			if (es_vacío (derecho(D2))) then
				return false;
			end if;
			-- Ninguno de los dos hijos es nulo, llamo recursivamente
			temp:=rcompro(izquierdo(d1),izquierdo(D2));
			if temp then
				return rcompro(derecho(d1),derecho(d2));
			else
				return false;
			end if;
		else 
			return false;
		end if;
	end rcompro;

end conjunto_de_palabras.adicional;

