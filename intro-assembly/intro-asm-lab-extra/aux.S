.data
	.globl c
	c: .byte 67
	
	.globl s
	.align 2
	s: .word 23
		
	.globl i
	.align 4
	i: .int 0
	
	.globl j
	.align 4
	j: .int 0	
		
	.globl l
	.align 8
	l: .quad 1023
	
	.globl ui
	.align 4
	ui: .int 2047
	
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
	
	#c = 93
	movb $93, %al
	movb %al, c
	
	#s = 75
	movw $75, %ax
	movw %ax, s
	
	#j = 52
	movl $52, %eax
	movl %eax, j
	
	#l = 7265
	movq $7265, %rax
	movq %rax, l
	
	#i = j
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
	
	#ui = i
	movl i, %r8d
	movl %r8d, ui
	
	#j = s
	movswl s, %r8d
	movl %r8d, j
	
	#ul = ui
	movl ui, %r8d
	movq %r8, ul
	
	#s = c + j 
	movsbl c, %r8d
	addl j, %r8d
	movw %r8w, s	
		
	
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

	# i = j * s
	movswl s, %edi
	imull j, %edi
	movl %edi, i
	
	# j = 1 + (s * 3)
	movswl s, %esi
	imull $3, %esi
	incl %esi
	movl %esi, j
	
	# ui = 2 * (i + s * 2)
	movswl s, %esi
	imull $2, %esi
	addl i, %esi
	imull $2, %esi
	movl %esi, ui
	
	# ul = (l + j * 3) - (s + 1024)
	
	# rdi = (l + j * 3)
	movslq j, %rdi
	imulq $3, %rdi
	addq l, %rdi
	
	# rsi = (s + 1024)
	movswq s, %rsi
	addq $1024, %rsi
	
	subq %rsi, %rdi
	movq %rdi, ul
	
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
	
	# c = c & 0x0F
	movb c, %dl
	andb $0x0F, %dl
	movb %dl, c
	
	# s = s | 0x80
	movw s, %dx
	orw $0x80, %dx
	movw %dx, s
	
	# i = i ^ 0x55
	movl i, %edx
	xorl $0x55, %edx
	movl %edx,  i
	
	# j = (j | s) ^ c
	movswl s, %edx
	orl j ,%edx
	
	movsbl c, %ecx
	xorl %edx, %ecx
	movl %ecx, j
	
	# l = l >> 2	???
	movq l, %rcx
	sarq $2, %rcx
	movq %rcx, l
	
	# ui = ui << 1
	movl ui, %ecx
	shll $1 ,%ecx
	movl %ecx, ui
	
	# ul = ul >> 4
	movl ul, %ecx
	shrl $4, %ecx
	movl %ecx, ul
	
	leave

	ret



#---------------------------------------------------------------------------------

	.globl ponteiros

ponteiros:

	pushq %rbp

	movq  %rsp, %rbp



	# Se necessário, usar apenas os registradores (ou suas variações) abaixo:

	# %rax, %rcx, %rdx, %rdi, %rsi, %r8, %r9, %r10, %r11



	# Seu código aqui...

	movq $s ,%rax
	movw $128 ,(%rax)

	leave

	ret
	
	
