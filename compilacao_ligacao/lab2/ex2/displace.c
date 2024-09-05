#include <stdlib.h>

#include <stdio.h>



typedef int (*FuncPtr)(int x);



void* build_exec(void *code, size_t size);



// Instruções da função (código de máquina)

unsigned char code[] = {

  // Colocar o hexadecimal do código aqui

  // 0x00, 0x00, ...

};





int main()

{

  int i;

  FuncPtr f;



  unsigned char *exec = build_exec(code, sizeof(code));



  //---------------------------------------

  // Alterar "process" para chamar a função "sum"



  // Seu código aqui...





  //---------------------------------------



  // Chama a função "process"



  //f = (FuncPtr)&exec[??];

  //i = f(40);

  //printf("%d\n", i);



  return 0;

}