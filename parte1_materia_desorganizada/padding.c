#include <stdio.h>

void dump(void *p, int n) {

  unsigned char *p1 = p;

  while (n--) {

    printf("%p - 0x%02X\n", p1, *p1);

    p1++;

  }

}

struct S1{
    short a;
    unsigned int b[3][2];
    char c;
    short d[5];
};

union U1{
    int x;
    char y;
    short z[2];
    char w[2][3];
};

struct S2{
    long l;
    struct S1 s;
    union U1 u;
};



int main(){
    struct S1 s1 = {
        .a = 0XAAAA, 
        .b[0][0] = 0xBBBBBBBB,
        .b[0][1] = 0xBBBBBBBB,
        .b[1][0] = 0xBBBBBBBB,
        .b[1][1] = 0xBBBBBBBB,
        .b[2][0] = 0xBBBBBBBB,
        .b[2][1] = 0xBBBBBBBB,
        .c = 0XCC,
        .d[0] = 0xDDDD,
        .d[1] = 0xDDDD,
        .d[2] = 0xDDDD,
        .d[3] = 0xDDDD,
        .d[4] = 0xDDDD,
    };

    union U1 u1 = {
        .x = 0xAAAAAAAA,
        .y = 0xBB,
        .z = 0xCCCC,
        .w[0][0] = 0xDD,
        .w[0][1] = 0xDD,
        .w[0][2] = 0xDD,
        .w[1][0] = 0xDD,
        .w[1][1] = 0xDD,
        .w[1][2] = 0xDD
    };

    struct S2 s2 = {
        .l = 0xEEEEEEEEEEEEEEEE,
        .s = s1,
        .u = u1
    };
    
    //printf("%ld\n", sizeof(unsigned int));
    dump(&s1, sizeof(s1));
    printf("\n");
    dump(&u1, sizeof(u1));
    printf("\n");
    dump(&s2, sizeof(s2));
    printf("\n");
    printf("%ld, %ld, %ld", sizeof(s1), sizeof(u1), sizeof(s2));


    return 0;
}