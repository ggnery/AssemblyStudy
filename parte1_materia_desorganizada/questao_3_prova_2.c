#include <stdio.h>

struct A{
    char *ptr;
    short displace;
    int age;
};

union U{
    struct A a;
    short s[6];
};

char names[3][3] = {"AB", "FG", "PQ"};
union U var;

void dump(void *p, int n) {

  unsigned char *p1 = p;

  while (n--) {

    printf("%p - %X\n", p1, *p1);

    p1++;

  }
  printf("============\n");

}


int main(){
    //printf("%p\n",&names[1][1]);
    //dump(&var, sizeof(var));
    var.a.ptr = &names[1][1];
    var.a.age = (int)(var.a.ptr[1] >> 1);

    var.a.displace = -24;
    dump(&(var.s[1]), sizeof(var.s[1]));
    dump(&var.a.displace, sizeof(var.a.displace));
    var.a.age = (int)(var.s[1] + var.a.displace);
    printf("%2X",var.a.age);

    return 0;
}
