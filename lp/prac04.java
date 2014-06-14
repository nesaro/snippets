import java.io.*;
//Clase principal
public class prac05 {
	public static void main(String[] argv) throws IOException {
		String nombre = new String();
		String apellidos = new String();
		String titulacion = new String();
		String grupo = new String();
		int gr;
		//Objeto tipo BufferedReader para leer del teclado
		BufferedReader teclado = new BufferedReader(new InputStreamReader(System.in));
		System.out.println("Procedemos a pedir datos:");
		System.out.println("Inserte el nombre:");
		nombre=teclado.readLine();
		System.out.println("Inserte los apellidos:");
		apellidos=teclado.readLine();
		System.out.println("Inserte la titulación:");
		titulacion=teclado.readLine();
		System.out.println("Inserte el grupo (nº):");
		grupo=teclado.readLine();
		// Controlo si el grupo se ha insertado correctamente
		try { gr=Integer.parseInt(grupo); }
		catch (NumberFormatException f){
			System.out.println("Error: El formato de grupo no es numérico");
			gr=0;
		}
		personal primero = new personal(nombre,apellidos,titulacion,gr);
		primero.muestra();
	}
}

class Nodo {
private Object contenido;
protected Nodo izq,der;

//Constructor sin parametros
public Nodo(Object entrada)
{
	contenido=entrada;
	izq=der=null;
}

public void anterior=(Nodo entrada) {
	izq=entrada;
}

public void siguiente=(Nodo entrada) {
	der=entrada;
}

public Nodo anterior(){return izq;}
public Nodo siguiente(){return der;}
//Seria un poco inutil la clase si no se pudise modificar el campo
public void nombre(String nom){nombre=nom;}
//Y sin acceso a dicho campo
public String nombre(){return nombre;}

public void apellidos(String nom){apellidos=nom;}
public String apellidos(){return apellidos;}

public void titulacion(String nom){titulacion=nom;}
public String titulacion(){return titulacion;}

public void grupo(int nom){grupo=nom;}
public int grupo(){return grupo;}
	
public void muestra() {
	System.out.println(nombre+","+apellidos+","+titulacion+","+grupo);
}
}
