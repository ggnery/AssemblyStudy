#include <stdio.h>

#define getsig(x) ((x) >> 31 & 1)

#define getexp(x) ((x) >> 23 & 0xff)

#define getfrac(x) ((x)&0x7fffff)

#define makefloat(s,e,f) ( (((s) & 1) << 31) | (((e) & 0xff) << 23) | ((f) & 0x7fffff) )

typedef union{
    float f;
    unsigned int i;
} U;

float process(float v){
    U u;
    unsigned int s, e, f;
    
    u.f = v; 
    s = getsig(u.i);
    e = getexp(u.i);
    f = getfrac(u.i);

    f = f | (e<<13);
    u.i = makefloat(s,e,f);

    return u.f;
}

int main(){
    printf("%f", process(2.5));
    return 0;
}