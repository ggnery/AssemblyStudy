.section .rodata

.data

.align 4
.globl  i
i: .int 0

.align 8
.globl bias
bias: .quad 256

.align 1
.globl vet
vet: .byte 12, 3, 20, 8

.text

.globl main

main:

    pushq %rbp

    movq  %rsp, %rbp

    # Seu código aqui...

    //for (i = 0; i < LEN; i++)
    // i = 0
    for01:
        cmpl $4, i
        jge end_for01

        //vet[i]
        movq $vet, %r9 //r9 = &vet 
        movslq i, %r10 //(long) i
        imulq $1, %r10 // (i * sizeof(char)) 
        addq %r9, %r10 // r10 = &vet +  (i * sizeof(char)) 
        movb (%r10), %r11b // r11 = vet[i]

        movb %r11b, %dil //1o parametro
        movw $10, %si // 2o paramtro
        movq bias, %rdx //3o parametro
        call filtro

        movq %rax, bias //bias = filtro

        incl i // i++
        jmp for01
    end_for01:
    # Faça o "return"
    movl $0, %eax //return 0

    leave

    ret