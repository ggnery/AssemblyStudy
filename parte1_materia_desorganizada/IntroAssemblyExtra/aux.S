	.data
    
    //char c = 67;
    .globl c
    .align 1
    c: .byte 67

    //short s = 23;
    .globl s
    .align 2
    s: .word 23

    //int i = 0;
    .globl i
    .align 4
    i: .int 0

    //int j = 0;
    .globl j
    .align 4
    j: .int 0

    //long l = 1023;
    .globl l 
    .align 8
    l: .quad 1023

    //unsigned int ui = 2047;
    .globl ui
    .align 4
    ui: .int 2047

    //unsigned long ul = 4095;
    .globl ul 
    .align 8
    ul: .quad 4095

	.text


#---------------------------------------------------------------------------------

	.globl atribuicoes

atribuicoes:

	pushq %rbp

	movq  %rsp, %rbp


	# Se necessário, usar apenas os registradores (ou suas variações) abaixo:

	# %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11


	# Seu código aqui...
    //c = 93
    movb $93, c

    //s = 75
    movw $75, s

    //j = 52
    movl $52, j

    //l = 7265
    movq $7265, l

    //i = j
    movl j, %eax
    movl %eax, i

	leave

	ret


#---------------------------------------------------------------------------------

	.globl cast

cast:

	pushq %rbp

	movq  %rsp, %rbp


	# Se necessário, usar apenas os registradores (ou suas variações) abaixo:

	# %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11


	# Seu código aqui...
    //ui = i
    movl i, %eax
    movl %eax, ui

    //j = s
    movw s, %ax
    movswl %ax, %ebx
    movl %ebx, j

    //ul = ui
    movl ui, %eax
    movl %eax, %ebx
    movq %rbx, ul

    //s = c + j
    movb c, %al 
    movsbl %al, %ebx // (int) c
    addl j, %ebx // c = c + j 
    movw %bx, s //s = c + j


	leave

	ret


#---------------------------------------------------------------------------------

	.globl expressoes

expressoes:

	pushq %rbp

	movq  %rsp, %rbp


	# Se necessário, usar apenas os registradores (ou suas variações) abaixo:

	# %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11

	# Seu código aqui...
    
    // i = j * s
    movw s, %ax
    movswl %ax, %ebx // (int) s
    imull j, %ebx // s = s * j
    movl %ebx, i

    // j = 1 + (s * 3)
    movw s, %ax
    movswl %ax, %ebx // s = (int) s
    imull $3, %ebx //s = s * 3
    incl %ebx // s = s + 1 
    movl %ebx, j // j = s
    
    // ui = 2 * (i + s * 2)
    movw s, %ax
    movswl %ax, %ebx // s = (int) s
    imull $2, %ebx // s = s * 2
    addl i, %ebx // s = i + s
    imull $2, %ebx // s = s * 2
    movl %ebx, ui // ui = s

    // ul = (l + j * 3) - (s + 1024);
    movl j, %eax // eax = j
    imull $3, %eax // j = 3 * j
    movl %eax, %ebx //  rbx = j = (long) j 
    addq l, %rbx // rbx = j = l + j

    movw s, %ax
    addw $1024, %ax // ax = s = 1024 + s 
    movswq %ax, %rcx // rcx = s = (long) s
    
    subq %rcx, %rbx  // rbx - rcx = rbx = j - s  
    movq %rbx, ul // ul = j - s

	leave

	ret


#---------------------------------------------------------------------------------

	.globl bitAbit

bitAbit:

	pushq %rbp

	movq  %rsp, %rbp


	# Se necessário, usar apenas os registradores (ou suas variações) abaixo:

	# %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11


	# Seu código aqui...


	leave

	ret


#---------------------------------------------------------------------------------

	.globl ponteiros

ponteiros:

	pushq %rbp

	movq  %rsp, %rbp


	# Se necessário, usar apenas os registradores (ou suas variações) abaixo:

	# %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11

    movq $s, %rax 
    movw 128, (%rax) 


	# Seu código aqui...


	leave

	ret