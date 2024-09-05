.section 

.data
    .globl v1
    .align 2
    v1: .word 1, 2

    .globl v2
    .align 8
    v2: .word 1, 2, 3

.text

.globl main
main:
    pushq %rbp
    movq %rsp, %rbp
    subq $8, %rsp 

    movl $1, %ecx //int i = ecx = 0

    // while (i < 2)
    while:
        cmpl $2, %ecx
        jge end_while

        movq %rcx, -8(%rbp) //salvo i

        movq $v1, %rdi //1o param
        movq %ecx ,%esi//2o param
        call aux
        movq -8(%rbp), %rcx //recupero i
        
        addl %ecx // i++

    end_while:

    movl $0, %eax //return 0
    leave
    ret

.globl aux
aux:
    pushq %rbp
    movq %rsp, %rbp

    

    leave
    ret

    