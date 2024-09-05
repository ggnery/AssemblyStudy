.section .rodata



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
	if01:	
		movl a, %eax # eax = a
		cmpl b, %eax
		jle end_if01
	
		negl c # c = -c
		
		# d = c / 3
		movl c, %eax #divisor
		cltd
		movl $3, %ecx #dividendo
		
		idiv %ecx
		
		movl %eax, d
	end_if01:
		
	if02:	
		movl b, %eax #eax = b
		cmpl a, %eax
		jl end_if02
		
		# c = (a + b) * c
		movl a, %edx
		addl b, %edx
		imull c, %edx
		movl %edx, c
			
		movl $1024, d
		
	
	end_if02:

	leave

	ret
