import javax.swing.*; 
import java.awt.*;
import java.awt.event.*;

public class Rating {

	double ds=0.0;

	public class Calcular {
		//clase de calculo
		//  Para cada parametro, una clase accesora y otra visora
		//  Un bit o algo para cada parametro, si no estan todos puestos no hay salida
		//  3 miembros q dan la salida para cada viento


	}

		// un panel ....
		//   // boton1, un dibujito, borde resaltado -> al pinchar abrir dialogo
		//   // // En el dialogo ... PANEL PRINCIPAL
		//   // // // un panel de montones, el primero es una foto explicativa, el resto paneles con 2 elementos, un label y un textfield <- actualizarian la clase de calculo (quiza mejor en otra clase) 
		//   // boton2, un dibujito, borde resaltado -> al pinchar abrir dialogo
		//   // // .....
		//
		//   una label... resultado = faltan datos o el valor para los tres vientos. Quiza un boton de calcular
	
		public static JPanel contenido() {
			JPanel mimain = new JPanel();
			JPanel principal = new JPanel();
			principal.setLayout(new GridLayout(0,4));
			JButton b1 = new JButton("Boton1");
			JButton b2 = new JButton("Boton2");
			JButton b3 = new JButton("Boton3");
			JButton b4 = new JButton("Boton4");
			JButton b5 = new JButton("Boton5");
			JButton b6 = new JButton("Boton6");
			JButton b7 = new JButton("Boton7");
			JButton b8 = new JButton("Boton8");
			b1.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent e) {
					JFrame frame = new JFrame();
					frame.setVisible(true); // Hacer el frame1
				}
			});
			principal.add(b1);
			principal.add(b2);
			principal.add(b3);
			principal.add(b4);
			principal.add(b5);
			principal.add(b6);
			principal.add(b7);
			principal.add(b8);


			//Panel de abajo

			JPanel resultado= new JPanel();
			JLabel temp = new JLabel("Resultados temporales proximamente");
			JLabel res = new JLabel("Resultados finales proximamente!!");
			resultado.add(temp);
			resultado.add(res);
			mimain.setLayout(new GridLayout(0,1));
			mimain.add(principal);
			mimain.add(resultado);
			return mimain;
		}
		// un menu .... 
		//   // Salir
		//   // Acerca de
		public static JMenuBar menu(){
			JMenuBar mimenu = new JMenuBar();
			JMenu jimenu = new JMenu();
			JMenuItem menuItem;
			JRadioButtonMenuItem rbMenuItem;
			JCheckBoxMenuItem cbMenuItem;
			jimenu.getAccessibleContext().setAccessibleDescription( "The only menu in this program that has menu items");
			menuItem = new JMenuItem("Archivo", new ImageIcon("images/middle.gif"));
			mimenu.add(menuItem);
			menuItem = new JMenuItem("Acerca de...");
			menuItem.setMnemonic(KeyEvent.VK_D);
			mimenu.add(menuItem);
			mimenu.add(jimenu);
			return mimenu;
		}

		public static void arrancar() {

			//decoracion de ventanas
			JFrame.setDefaultLookAndFeelDecorated(true);
			//Ventana principal
			JFrame frame = new JFrame("Rating");
			frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
			JMenuBar menu = menu();
			frame.setJMenuBar(menu);
			JPanel contenido = contenido();
			frame.setContentPane(contenido);
			//Display the window.
			frame.pack();
			frame.setVisible(true);
		}




		public static void main(String[] args) {
			//Schedule a job for the event-dispatching thread:
			//creating and showing this application's GUI.
			javax.swing.SwingUtilities.invokeLater(new Runnable() {
				public void run() {
					arrancar();
				}
			});
		}
		//clase principal
		//  llamar a la interfaz
		//  si salir pues salir


}
