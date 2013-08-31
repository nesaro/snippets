#include <iostream>
using namespace std;

int main()
{
  int pid = fork();  
  if (pid==0)
    {
      for (int i=0; i<100000;i++)
	{
	  cout << "hola\n";
	  //sleep(1);
	  }
    }
  else
    {
      for (int i=0; i<100000;i++)
	{
	  cout << "adios\n";
	  //sleep(1);
	}
    }
      return 0;
} 
