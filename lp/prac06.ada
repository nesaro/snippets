WITH Ada.Text_IO,Ada.Integer_Text_IO,Ada.Numerics.Discrete_Random;
USE Ada.Text_IO,Ada,Ada.Integer_Text_IO;

PROCEDURE Principal IS
	subtype P�ginas is Integer range 1..100;
	package RandomP�ginas is new Ada.Numerics.Discrete_Random (P�ginas);
	use RandomP�ginas;
	subtype Duraci�n is Integer range 1..100;
	package RandomDuraci�n is new Ada.Numerics.Discrete_Random (Duraci�n);
	use RandomDuraci�n;

	-- Implemente la especificaci�n de las Tareas.
	TASK TYPE LlenaCola;
	TASK TYPE Vac�aCola;

	-- Implemente la especificaci�n de MonitorCola.
	type vector is Array(1..20) of Integer;
	protected type MonitorCola is
		Procedure A�adirTrabajo (N:integer);
		Procedure ImprimirTrabajo;
		function primero return integer;
		function numero return integer;
		private
		procedure mostrar;
		vacio: Boolean:=true; 
		elementos: vector;
		primer,ultimo: integer:=1 ; -- Para controlar los limites del vector
	end MonitorCola;

	ColaImpresi�n : MonitorCola; -- Variable de tipo protegido (protected).

	-- Implemente el cuerpo de MonitorCola.
	
	protected body MonitorCola is

		-- A�adirTrabajo pone un trabajo en la cola comprobando que 
		-- no la corrompe
		Procedure A�adirTrabajo (N:integer) is
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
		end A�adirTrabajo;
		
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

		-- primero devuelve el n�mero de p�ginas del primer trabajo
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

		-- mostrar devuelve la salida requerida en el gui�n
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

	-- Implemente el cuerpo de la Tarea Vac�aCola.
	-- VaciaCola gestiona la salida de trabajos a impresora, respetanto un tiempo de 0.2 segundos en caso 
	-- de que no haya trabajos pendientes
	TASK BODY Vac�aCola IS
	BEGIN
		LOOP
			if ColaImpresi�n.numero > 0 then
				delay Duration(0.02*ColaImpresi�n.primero);
				ColaImpresi�n.ImprimirTrabajo;
			else
				delay Duration(0.2);
			end if;
		END LOOP;
	end Vac�aCola;


	-- Implementaci�n del cuerpo de LLenaCola. Esta tarea env�a trabajos a la cola de impresi�n
	-- con una frecuencia de 0.7 trabajos por segundo como media. As�mismo dichos trabajos poseen
	-- 50 p�ginas como media. Si se desea puede modificar el n�mero 35 para comprobar como se llena o
	-- se mantiene vac�a la cola, dado que se modifica la frecuencia de env�o de los trabajos.
	TASK BODY LlenaCola IS
		G1: RandomDuraci�n.generator;
		G2: RandomP�ginas.generator;
	BEGIN
		reset(G1);
		reset(G2);
		LOOP
			ColaImpresi�n.A�adirTrabajo(random(G2));
			delay Duration(float(random(G1))/35.0);
		END LOOP;
	END LlenaCola;

	-- Variables de tipo tarea (task).
	A,C:LlenaCola;
	B:Vac�aCola;

BEGIN 
	null;
END Principal;
