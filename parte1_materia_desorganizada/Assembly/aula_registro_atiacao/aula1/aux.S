    .section .rodata
        fmt: .string "Valor: x = %ld, i = %d\n"
    
    .data
    
        .globl x
        .align 8
        x: .quad 10

    .text
    .globl aux

aux:
    pushq %rbp 
    movq %rsp, %rbp
    subq $16, %rsp
    
    # x = 5
    movq $5, x
    
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)

    movl %edi, %edx #3o. param
    movq $fmt, %rdi #1o. param
    movq x, %rsi #2o. param

    movl $0, %eax
    call printf

    movq -8(%rbp), %rdi #i
    movq -16(%rbp), %rsi #ptr

    movslq %edi, %rax
    addq x, %rax
    addq (%rsi), %rax

    leave 
    ret