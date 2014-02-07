/* Prolog examples */

/*Los hermanos tienen a su padre en comun */
hermano(X,Y) :-padre(Z,X),padre(Z,Y).
/*Los padres de los primos son hermanos*/
primo(X,Y) :-hermano(padre(Z,X),padre(Z,Y)).
/*La definicion de nieto... */
nieto(X,Y) :-padre(Z,X),padre(Y,Z).

/*descendiente: Uno es descendiente de si mismo,
y si no pues preguntamos por la siguiente generacion */

descendiente(X,X).
descendiente(X,Y):-padre(Y,Z),descendiente(X,Z).
/*longitud: voy sumando uno al resto de la lista hasta llegar a la vacia */

longitud([],0).
longitud([_|L1],N) :- longitud(L1,N1), N is N1+1.
/*ocurrencia: paso por todos los elementos y resto 1 por cada coincidencia,hasta llegar a la lista vacia */

ocurrencia(_,[],0).
ocurrencia(X,[X|L2],N) :- ocurrencia(X,L2,C), N is C+1.
ocurrencia(X,[_|L2],N) :- ocurrencia(X,L2,N).
/*Posicion: Voy restando por cada movimiento y veo si coincide la posicion uno con el elemento pedido*/

posicion(1,[X|_],X).
posicion(N,[_|L2],X) :- posicion(J,L2,X),N is J+1.
/*concatena: Vacio la primera lista, siempre que coincida con el resultado, y despues comparo lo que queda con la segunda*/

concatena([],X,X).
concatena([X|X2],Y,[X|Z2]) :- concatena(X2,Y,Z2).
/*Miembro recorre toda la lista hasta que encuentra algunca coincidencia*/

miembro(X,[X|_]).
miembro(X,[_|B]):- miembro(X,B).

/*Subconjunto: vamos filtrando cada elemento de L hasta obtener la lista vacia*/

subconjunto([],_).
subconjunto(L,L).
subconjunto([X|L],C):- miembro(X,C),subconjunto(L,C).

/*Disjuntos: comprobamos para cada elemento de uno de los conjuntos que no pertenece al otro.*/

disjuntos(_,[]).
disjuntos([],_).
disjuntos(L,[A|B]):- not(miembro(A,L)),disjuntos(L,B).

/*Union: Vamos reduciendo el primer y el tercer conjunto, hasta poder verificar que el segundo y el tercero son iguales*/

union([],A,A).
union([A|B],C,D):- miembro(A,C), union(B,C,D).
union([A|B],C,D):- miembro(A,B), union(B,C,D).
union([A|B],C,[A|D]):- union(B,C,D).

/*Interseccion: La interseccion de dos conjuntos disjutnos es [].
A partir de ahi, intento reducir o bien el primero o bien el tercero
Si un elemento pertenece al primero y no al segundo, puedo prescindir de el en la siguiente llamada
Si un elemento esta en los tres, puedo eliminarlo de dos de ellos y se mantiene la propiedad.
*/
interseccion([],_,[]).
interseccion(_,[],[]).
interseccion(A,B,[]):-disjuntos(A,B).
interseccion([A|C],D,[A|E]):-miembro(A,D),interseccion(C,D,E).
interseccion([A|C],D,E):- not(miembro(A,D)),interseccion(C,D,E).

/*Diferencia:
Intento reducir el primero la resta. Si un elemento esta en el primero y en la resta, y no en el segundo, lo quito de estos dos conjuntos.
Si un elemento esta en los dos conjuntos, lo puedo extraer del primero y se deberia seguir manteniendo la propiedad.
*/

diferencia([],_,[]).
diferencia(A,B,A):-disjuntos(A,B).
diferencia([A|B],C,[A|D]):-not(miembro(A,C)),diferencia(B,C,D).
diferencia([A|B],C,D):-miembro(A,C),diferencia(B,C,D).

/*Reemplaza: Recorre la cadena comprobando que son diferentes o bien
pasando en caso de que coincidan ambos */

reemplaza([],_,_,[]).
reemplaza([A|B],X,Y,[A|D]):-A\=X,reemplaza(B,X,Y,D).
reemplaza([X|B],X,Y,[Y|D]):-reemplaza(B,X,Y,D).

/*Borra: Pasa por toda la lista comprobando que las apariciones en la lista original de X no existen en la lista resultado */
borra([],_,[]).
borra([A|B],X,[A|D]):-A\=X,borra(B,X,D).
borra([X|B],X,D):-borra(B,X,D).

