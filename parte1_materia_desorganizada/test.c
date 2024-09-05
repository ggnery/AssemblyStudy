#include <stdio.h>

void dump(void *p, int n) {

  unsigned char *p1 = p;

  while (n--) {

    printf("%p - %X\n", p1, *p1);

    p1++;

  }

}



int main(){
    short a = 0x8BA6;
    short b = 0xFFE8;

    int c = (int)(a+b);

    printf("0x%X", c);
    return 0;
}