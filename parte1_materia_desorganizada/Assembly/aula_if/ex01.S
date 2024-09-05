.data

.globl a
.align 4
a: .int 30

.globl b
.align 4
b: .int 45

.globl c
.align 4
c: .int -60

.globl d
.align 4
d: .int 25

.text

.globl ex01

ex01:

    pushq %rbp

    movq  %rsp, %rbp


    # Seu código aqui...
    
    movl a, %eax

    //if(a > b)
    cmpl b, %eax
    jle depois_if_1

    //c = -c
    negl c

    //d = c / 3
    movl c, %eax
    cqto // apaga rdx
    movl $3, %ecx
    idiv %ecx //eax -> quociente, %edx -> resto

    movl %eax, d

    depois_if_1:

    // if (b >= a)
    movl a, %eax
    cmpl %eax, b 
    jl depois_if_2

    // c = (a + b) * c 
    movl a, %eax
    addl b, %eax     
    imul c, %eax
    movl %eax, c

    //d = 1024
    movl $1024, d
    depois_if_2:

    leave

ret