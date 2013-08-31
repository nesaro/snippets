#include <stdio.h>
long int fact(long int x){
	if (x == 1) {
		return 1;
	} else {
		return x * fact(x-1);
	}
}

int main(){
 	int i = 0;
	printf("%d",fact(100));
	return 0;
}
