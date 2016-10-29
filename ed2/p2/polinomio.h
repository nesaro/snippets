#ifndef __POLINOMIO_H
#define __POLINOMIO_H
class Polinomio
{
	public:
		Polinomio(int);
		~Polinomio();
		Polinomio(const Polinomio &); //Constructor de copia
		float& operator[](int) const; //Operador [], devuelve una referencia al valor
		Polinomio & operator =(const Polinomio &);
		int grado() const;
		float valor(float) const;
		void muestra() const;
		friend Polinomio operator +(const Polinomio &,const Polinomio &);
		friend Polinomio operator -(const Polinomio &,const Polinomio &);
		friend Polinomio operator -(const Polinomio &); //al principio
		friend Polinomio operator *(const Polinomio &,const Polinomio &);
	private:
		float* datos;
		int maxexp;

};
#endif
