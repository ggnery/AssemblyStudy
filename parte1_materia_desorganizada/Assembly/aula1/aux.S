.data
    .globl c 
    .align 1
    c: .byte -20
    
    .globl i
    .align 4
    i: .int -256
    
    .globl j 
    .align 4
    j: .int 512
    
    .globl l
    .align 8
    l: .quad 128

    .globl us
    .align 2
    us: .short 111
    
    .globl ui
    .align 4
    ui: .int 1025

    .globl ul
    .align 8
    ul: .quad 2048

.text


.globl aux

aux:

    pushq %rbp

    movq  %rsp, %rbp


    # Se necessário, usar apenas os registradores (ou suas variações) abaixo:

    # %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11


    # Seu código aqui...
    movl $68000, j
    movq $4096, l
    movl j, %eax
    movl %eax, i

    movl i, %eax
    addl $10, %eax
    subl $5, %eax
    movl %eax, j
    
    
    movl i, %eax
    imull $2, %eax

    movl j, %ecx
    addl $5, %ecx

    subl %ecx, %eax
    movl %eax, i
    

    leave

    ret