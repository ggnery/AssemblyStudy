.section .rodata

str01: .string "Hello"

.data

.align 4
.globl val
val: .int 432

.align 2
.globl age
age: .word 4

.align 4
.globl r
r: .int 0

.align 8
.globl err
err: .quad 2058

.text


.globl main

main:

   pushq %rbp

   movq  %rsp, %rbp



   # Seu código aqui...
    #sum("Hello", val, age, &r);
    movq $str01, %rdi //1o param
    movl val, %esi //2o param
    movw age, %dx //3o param
    movq $r, %rcx //4o param
    call sum
    # retorno %eax

    movl %eax, val

    #show(err, val, r);
    movq err, %rdi //1o param
    movl val, %esi //2o param
    movl r, %edx //3o param
    call show

    movl $0, %eax

   leave

   ret