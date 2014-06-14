WITH Ada.Text_IO,Ada.Integer_Text_IO,Ada.Numerics.Discrete_Random;
USE Ada.Text_IO,Ada,Ada.Integer_Text_IO;

PROCEDURE Principal IS
	subtype Páginas is Integer range 1..100;
	package RandomPáginas is new Ada.Numerics.Discrete_Random (Páginas);
	use RandomPáginas;
	subtype Duración is Integer range 1..100;
	package RandomDuración is new Ada.Numerics.Discrete_Random (Duración);
	use RandomDuración;

	-- Implemente la especificación de las Tareas.
	TASK TYPE LlenaCola;
	TASK TYPE VacíaCola;

	-- Implemente la especificación de MonitorCola.
	type vector is Array(1..20) of Integer;
	protected type MonitorCola is
		Procedure AñadirTrabajo (N:integer);
		Procedure ImprimirTrabajo;
		function primero return integer;
		function numero return integer;
		private
		procedure mostrar;
		vacio: Boolean:=true; 
		elementos: vector;
		primer,ultimo: integer:=1 ; -- Para controlar los limites del vector
	end MonitorCola;

	ColaImpresión : MonitorCola; -- Variable de tipo protegido (protected).

	-- Implemente el cuerpo de MonitorCola.
	
	protected body MonitorCola is

		-- AñadirTrabajo pone un trabajo en la cola comprobando que 
		-- no la corrompe
		Procedure AñadirTrabajo (N:integer) is
		begin
			if vacio then --Vacio
				vacio:=false;
				primer:=1;
				ultimo:=1;
				elementos(1):=N;
				mostrar; --Hay cambio, llamo a mostrar
				return;
			end if;
			if ((ultimo+1) mod 20) = primer then --LLeno
				return;
			end if;
			if ultimo=20 then 
				ultimo:=0;
			end if;
			ultimo:=ultimo+1;
			elementos(ultimo):=N;
			vacio:=false;
			mostrar; --Hay cambio, llamo a mostrar
		end AñadirTrabajo;
		
		-- ImprimirTrabajo elimina un trabajo de la cola siempre que
		-- esta contenga algun elmento
		Procedure ImprimirTrabajo is
		begin
			if vacio then --Vacio
				primer:=1;
				ultimo:=1;
				return; 
			end if;
			if primer=ultimo then --Solo un elemento 
				primer:=1;
				ultimo:=1;
				vacio:=true;
				mostrar; --Hay cambio, llamo a mostrar
				return;
			end if;
			if primer=20 then
				primer:=0;
			end if;
			primer:=primer+1;
			mostrar;  --Hay cambio, llamo a mostrar
		end ImprimirTrabajo;

		-- primero devuelve el número de páginas del primer trabajo
		function primero return integer is
		begin
			if not vacio then
				return elementos(primer);
			end if;
			return 0;
		end primero;

		-- numero devuelve el numero de trabajos pendientes
		function numero return integer is
		begin
			if vacio then
				return 0;
			end if;
			if ultimo >= primer then
				return ultimo-primer+1;
			end if;
			return (21-(primer-ultimo));
		end numero;

		-- mostrar devuelve la salida requerida en el guión
		procedure mostrar is
		begin
			put("Cola[");
			put(numero,0);
			put("] -> ");
			for i in reverse 0..numero-1 loop
				put ((elementos(((primer+i-1) mod 20)+1)),0);
				put (",");
			end loop;
			put_line("");
		end mostrar;

	end MonitorCola;

	-- Implemente el cuerpo de la Tarea VacíaCola.
	-- VaciaCola gestiona la salida de trabajos a impresora, respetanto un tiempo de 0.2 segundos en caso 
	-- de que no haya trabajos pendientes
	TASK BODY VacíaCola IS
	BEGIN
		LOOP
			if ColaImpresión.numero > 0 then
				delay Duration(0.02*ColaImpresión.primero);
				ColaImpresión.ImprimirTrabajo;
			else
				delay Duration(0.2);
			end if;
		END LOOP;
	end VacíaCola;


	-- Implementación del cuerpo de LLenaCola. Esta tarea envía trabajos a la cola de impresión
	-- con una frecuencia de 0.7 trabajos por segundo como media. Asímismo dichos trabajos poseen
	-- 50 páginas como media. Si se desea puede modificar el número 35 para comprobar como se llena o
	-- se mantiene vacía la cola, dado que se modifica la frecuencia de envío de los trabajos.
	TASK BODY LlenaCola IS
		G1: RandomDuración.generator;
		G2: RandomPáginas.generator;
	BEGIN
		reset(G1);
		reset(G2);
		LOOP
			ColaImpresión.AñadirTrabajo(random(G2));
			delay Duration(float(random(G1))/35.0);
		END LOOP;
	END LlenaCola;

	-- Variables de tipo tarea (task).
	A,C:LlenaCola;
	B:VacíaCola;

BEGIN 
	null;
END Principal;
