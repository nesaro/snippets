import java.io.*;
//Clase principal
public class prac05 {
	public static void main(String[] argv) throws IOException {
		//Pruebas decontenedor vacio
	 	System.out.println("Prueba de 0 elementos:");
		Cola eje1 = new Cola(10);
		System.out.println(eje1.extraer());
		System.out.println(eje1.primero());
		eje1.concatenar(eje1);
		//Pruebas de contenedor de 1 elemento
		System.out.println("Prueba de 1 elemento:");
		Integer i = new Integer(40);
		Integer j = new Integer(80);
		eje1.insertar(i);
		System.out.println(eje1.primero().dato());
		System.out.println(eje1.extraer());
		System.out.println(eje1.extraer());
		eje1.insertar(i);
		System.out.println(eje1.primero().dato());
		Cola eje2 = new Cola(10);
		eje2.insertar(j);
		System.out.println(eje2.extraer());
		eje2.insertar(j);
		//Pruebas de contenedor de mas de un elemento
		System.out.println("Prueba de concatenacion 1+1:");
		eje1.concatenar(eje2);
		System.out.println(eje2.extraer()); //Debe estar vacio
		System.out.println(eje1.extraer());
		System.out.println(eje1.extraer());
		System.out.println(eje1.extraer());
		System.out.println("Prueba de mas de 1 elemento:");
		eje1.insertar(i);
		eje1.insertar(j);
		eje1.insertar(i);
		eje2.insertar(i);
		eje2.insertar(j);
		System.out.println(eje1.extraer());
		System.out.println(eje1.extraer());
		System.out.println(eje1.extraer());
		System.out.println(eje1.extraer());
		eje1.insertar(i);
		eje1.insertar(j);
		eje1.insertar(i);
		System.out.println(eje1.primero().dato());
		System.out.println("Prueba de concatenacion 3+2:");
		eje1.concatenar(eje2);
		System.out.println(eje1.extraer());
		System.out.println(eje1.extraer());
		System.out.println(eje1.extraer());
		System.out.println(eje1.extraer());
		System.out.println(eje1.extraer());
		//Prueba con elementos string
		System.out.println("Prueba de cadenas:");
		String texto1 = new String("prueba1");
		String texto2 = new String("prueba2");
		String texto3 = new String("prueba3");
		eje1.insertar(texto1);
		eje1.insertar(texto2);
		eje2.insertar(texto3);
		eje1.concatenar(eje2);
		System.out.println(eje1.extraer());
		System.out.println(eje1.extraer());
		System.out.println(eje1.extraer());
		System.out.println(eje1.extraer());
	}
}


//NODO
class Nodo {
private Object contenido;
protected Nodo der;
public Nodo(Object entrada) { contenido=entrada; der=null; } //Constructor
public void siguientees(Nodo entrada) { der=entrada; } //asignacion del siguiente nodo
public Object dato(){ return contenido; } //Devuelve el contenido
public Nodo siguiente(){return der;} // Devolucion del siguiente nodo
}


//COLA
class Cola {
private Nodo primero;
private int max,tam;
public Cola(int entrada){ max=entrada; } //Constructor
public Nodo primero() { return primero;} //Devuelve el primero

//insertar: Inserta un elemento, controlando si la cola esta vacia o no
public boolean insertar(Object entrada)
{
	if (tam==max) { return false; } //Hemos llegado al tope
	Nodo temp = new Nodo(entrada); 
	if (tam==0) { primero=temp;tam=1;return true; } 
	Nodo iterador=primero; int i = 1; 
	while (i<tam) { iterador=iterador.siguiente(); i++; } 
	iterador.siguientees(temp);tam+=1; 
	return true;
}


//Extrae: extrae un elemento de la cola, comenzando ahora por el segundo
public Object extraer() 
{
	if (tam==0) { return null; }
	Object temp = primero.dato();
	primero=primero.siguiente();
	tam--;
	return temp;
}
public static Nodo siguiente(Nodo entrada){ return entrada.siguiente(); }

//Concatenar: busca el ultimo nodo del contenedor actual, y enlaza el siguiente con el  principio  del
// contenedor de de entrada. Despues pone a 0 el segundo contenedor.
public void concatenar(Cola entrada){
	if (this==entrada) {return;}
	if (entrada.tam==0) {return;}
	Nodo iterador=primero; int i = 1;
	while (i<tam) { iterador=iterador.siguiente(); i++; } //Se coloca al final 
	iterador.siguientees(entrada.primero());
	tam+=entrada.tam;
	entrada.primero=null;entrada.tam=0;
}
}

