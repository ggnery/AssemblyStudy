#include <stdio.h>
#define getfrac(x) ((x) & 0x7fffff)

typedef union{
    float f;
    unsigned int i;
} U;

void dump(void *p, int n) {

  unsigned char *p1 = p;

  while (n--) {

    printf("%p - %.8b\n", p1, *p1);

    p1++;

  }

}

void show(){
    U u1, u2;

    u1.f = 32.0;
    u2.f = 40.250;
    
    
    unsigned int f = getfrac(u2.i);
    dump(&f, sizeof(f));
    printf("Resposta = %X\n", (u1.i >> 9) ^ f);
}

int main(){
    show();

    return 0;
}