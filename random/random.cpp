#include <iostream>
using namespace std;

int main(){
	for (int i=0; i < 65536; i++)
	{
		cout << rand()%2;
	}
	return 0;
}
