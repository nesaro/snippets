#ifndef __FRACCION_H 
#define __FRACCION_H

class Fraccion
{
	public:
		Fraccion(int num=0 ,int den=1);
		int numerador() const;
		int denominador() const;
		float valor() const;
 		Fraccion operator -(const Fraccion&) const;
 		Fraccion operator /(const Fraccion&) const;
		Fraccion inversa() const;
		void numeroMixto(int&,int&, int&) const;
		Fraccion elevadoA(int) const;
		friend Fraccion operator+(const Fraccion& ,const Fraccion& );
		friend Fraccion operator*(const Fraccion& ,const Fraccion& );
	private:
		int num,den;
		static int euclides(int,int);
		void reducir(); 
};
		
#endif
