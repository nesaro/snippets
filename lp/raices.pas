Program raices;

TYPE TipoFun = function(X:Real):Real;
TYPE TipoVector = ARRAY [1..10] Of double;
VAR nres,j,opcion,li,ls:Integer;
VAR lsup,linf,delta:real;
VAR solucion: TipoVector;

(* Resuelve: utiliza el método de la bisección sobre un intervalo *)
function resuelve (f:TipoFun;linf:real;lsup:real;delta:real):real;
	VAR
	mitad: real;
	BEGIN
		mitad:=(lsup+linf)/2;
		IF f(lsup)=0 then (* Encuentro la raiz en un extremo *)
		BEGIN
			resuelve := lsup;
			exit;
		END;
		IF f(linf)=0 then(* Encuentro la raiz en un extremo *)
		BEGIN
			resuelve:= linf;
			exit;
		END;
		if f(mitad)=0 then(* Encuentro la raiz en la mitad*)
		BEGIN
			resuelve:=mitad;
			exit;
		END;
		if (lsup-linf)<delta then(* el intervalo queda pequeño*)
		BEGIN
			resuelve:= mitad;
			exit;
		END;
		if f(linf)*f(mitad)<0 then(*Sigo buscando*)
		BEGIN
			resuelve:= resuelve(f,linf,mitad,delta);
			exit;
		END;
		resuelve:= resuelve (f,mitad,lsup,delta);
	END;


(*Raices es la funcion principal*)
function raices(f: TipoFun; linf, lsup,delta : real; var soluciones: TipoVector):integer;
	VAR i,nresultado: integer;
	VAR tintervalo,nintervalos,lsuperior,linferior: real;
	BEGIN
		i:=0;
		nintervalos:=1/(100*delta);
		tintervalo:=(lsup-linf)*(delta*100);
		nresultado:=0;
		while i<=nintervalos DO
		BEGIN
			linferior:=linf+tintervalo*i;
			lsuperior:=linferior+tintervalo;
			if f(linferior)=0 then
			BEGIN
				soluciones [nresultado+1] := linferior;
				nresultado:=nresultado+1;
				linferior:=linferior+delta;
			END;
			IF f(lsuperior)=0 THEN
			BEGIN
				soluciones [nresultado+1] := lsuperior;
				nresultado:=nresultado+1;
				i:=i+1; (* Si encuentro una raiz en un limite salto el siguiente intervalo *)
				lsuperior:=lsuperior-delta;
			END;
			if (f(linferior)*f(lsuperior)<0) then
			BEGIN
				soluciones [nresultado+1]:= resuelve(f,linferior,lsuperior,delta);
				nresultado:=nresultado+1;
			END;
			i:=i+1
		END;
	raices:= nresultado;
	END;

(* Funciones que son pasadas como objetos *)
{$F+}function f1(x:real):real;
	BEGIN
		f1:= (x*x)+x-12;
	END;

{$F+}function f2(x:real):real;
	BEGIN
		f2:= (x*x)-(3*x)+2;
	END;
{$F+}function f3(x:real):real;
	BEGIN
		f3:= (x*x)-(2*x);
	END;
{$F+}function f4(x:real):real;
	BEGIN
		f4:= sin(x)/(x+11);
	END;

BEGIN
	nres:=raices( f1 , -10.0 , 10.0 , 0.001 , solucion );
	writeln('Bienvenido al buscador de soluciones');
	writeln('¿Qué ecuación desea utilizar?');
	writeln('1.x^2 + x -12');
	writeln('2.x^2-3x+2 ');
	writeln('3.x^2-2x ');
	writeln('4.sen(x)/(x+11)');
	Readln(opcion);
	writeln('\n¿Limite inferior?');
	Readln(li);
	writeln('¿Limite superior?');
	Readln(ls);
	writeln('¿Precisión?');
	Readln(delta);
	linf:=li;
	lsup:=ls;
	case opcion of
		1 : nres:=raices(f1,linf,lsup,delta,solucion);
		2 : nres:=raices(f2,linf,lsup,delta,solucion);
		3 : nres:=raices(f3,linf,lsup,delta,solucion);
		4 : nres:=raices(f4,linf,lsup,delta,solucion);
		otherwise	nres:=0 ;
	END;
	writeln('Las soluciones son');
	FOR j:=1 TO nres DO
	BEGIN
		writeln(solucion[j]);
	END
END.

