.data

.globl c
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
us: .word 111

.globl ui
.align 4
ui: .int 1024

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
	
	#Atribuicoes simples
		
	movl $68000, j # j = 68000
	movq $4096, l # l = 4096 
	
	#i = j
	movl j, %eax
	movl %eax, i
	
	
	# Expressoes
	
	# j = 10 + i - 5
	movl i, %eax # eax = i
	addl $10, %eax # eax = eax + 10
	subl $5, %eax # eax = eax - 5
	movl %eax, j # i = eax
	
	# i = (i*2) - (j + 5)
	
	#(i * 2)
	movl i, %eax
	imull $2, %eax
	#(j + 5)
	movl j, %ecx
	addl $5, %ecx
	
	subl %ecx, %eax
	movl %eax, i
	
	
	#Casts
	
	# ui = i
	movl i, %eax
	movl %eax, ui	
	
	# j = c
	movsbl c, %ecx
	movl %ecx, j
	
	# ul = ui
	movl ui, %eax
	movq %rax, ul
	
	# us = ul
	movq ul, %rax
	movw %ax, us
	
	# c = i + j
	movl i, %eax 
	movl j, %ecx
	addl %eax, %ecx
	movb %cl, c
	
	# ponteiros 
	movq $l, %rax
	movl $128, (%rax)
	
	movq $i, %rcx
	movl j, %edx
	addl (%rcx), %edx
	movl %edx, j
	
	
	leave

	ret
