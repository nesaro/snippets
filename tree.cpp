#include <iostream>
using namespace std;

struct nodo
{
  nodo * hijo1;
  nodo * hijo2;
  void procrear();
  nodo();
};

nodo::nodo()
{
  hijo1=NULL;
  hijo2=NULL;
}

void nodo::procrear()
{ 
  int suerte= (rand()%10);
  if (suerte >= 5)
    {
      if (hijo1!=NULL)
	{
	  hijo1->procrear();
	}
      else 
	{
	  hijo1 = new nodo;
	  cout << "Soy: " << this<< " y, ha salido un niño\n";
	}
    }
  else 
    {
      if (hijo2!=NULL)
	{
	  hijo2->procrear();
	}
      else 
	{
	  hijo2 = new nodo;
	  cout << "Soy: " << this<< " y, ha salido un niña\n";
	}
    }
}

int main()
{
  nodo * tatarabuelo;
  tatarabuelo = new nodo;
  int i;
  for (i=0;i<300;i++)
    {
      tatarabuelo->procrear();
    }
    return 0;
}

