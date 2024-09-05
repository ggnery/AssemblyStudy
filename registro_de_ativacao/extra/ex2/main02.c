#include <stdlib.h>

#include <stdio.h>



int result = 0;

char values[] = {10, 20, 30, 40};

long bases[]  = {0xAA0000, 0xBB0000, 0xCC0000, 0xDD0000};



int imerge(int x, char y)

{

   return x | y;

}



long lmerge(long a, char b)

{

   int tmp = (int)a | ( (int)b << 8 );

   return a | imerge(tmp, b);

}



int main()

{

   int i, j;

   for (i = 0, j = 3; i < 4; i++, j--) {

      result = (int)lmerge(bases[i], values[j]);

      printf("Result 0x%X\n", result);

   }

   return 0;

}
