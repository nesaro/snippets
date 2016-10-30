#include <iostream>
using namespace std;

int main()
{
	srand(2); //inicializa un pseudo generador de numeros aleatorios, cambia segun el argumento
	while ( true )
	{
	cout << (rand()%10) << "\n"; //muestra un numero aleatorio modulo 10. Este método no es muy bueno ya que es más probable
	// que toque un valor bajo que un valor alto
	}
	return 0;
}
