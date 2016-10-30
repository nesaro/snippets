#ifndef __COMPONENTE_H
#define __COMPONENTE_H
#include <string>
using namespace std;

class Componente
{
	public:
		virtual ~Componente();
		virtual string aRistra() const=0; //virtual pura
		virtual int ncaracteres() const=0; 
		virtual int npalabras() const; //no es virtual pura, asumo 
									  // que un componente generico solo tiene 1 palabra
		virtual Componente* copia() const=0;
};
class ComponenteNumero: public Componente
{
	public:
		ComponenteNumero(int);
		string aRistra() const;
		int ncaracteres() const;
		ComponenteNumero* copia() const;
	private:
		int valor;
};
class ComponenteFecha: public Componente
{
	public:
		ComponenteFecha(time_t);
		string aRistra() const;
		int ncaracteres() const;
		ComponenteFecha* copia() const;
	private:
		time_t fecha;
};
class ComponenteCompuesto: public Componente
{
	public:
		~ComponenteCompuesto();
		ComponenteCompuesto();
		ComponenteCompuesto & operator =(const ComponenteCompuesto&);
		ComponenteCompuesto(const ComponenteCompuesto &);
		void anade(Componente *);
		string aRistra() const;
		int npalabras() const;
		int ncaracteres() const;
		ComponenteCompuesto* copia() const;
	private:
		Componente* contenedor[100]; //vector de 100
		int mfin; //marcador
};

class ComponenteTexto: public Componente
{
	public:
		ComponenteTexto(const char *);
		string aRistra() const;
		int npalabras() const;
		int ncaracteres() const;
		ComponenteTexto* copia() const;
	private:
		string contenido;
};
#endif
