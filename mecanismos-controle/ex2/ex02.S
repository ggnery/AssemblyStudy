.section .rodata



.data

.globl a
.align 4
a: .int 0

.globl b
.align 8
b: .quad 2


.text

.globl ex02

ex02:

	pushq %rbp

	movq  %rsp, %rbp



	# Seu código aqui...
	if01:
		
		cmpl $0, a
		je end_if01
		
		if02:
			
			cmpq $5, b
			jge else_if02
			
			# b = (a << 1) + (a * b)
			# (a << 1)
			movslq a, %rcx
			shlq $1, %rcx
			
			# (a * b)
			movslq a, %rdx
			imulq b, %rdx
			
			#(a << 1) + (a * b)
			addq %rdx, %rcx
			movq %rcx, b
		
			jmp end_else_if02
		end_if02:	
		
		else_if02:
			movq b, %rdi
			xorq $0x1F, %rdi
			movl %edi, a
		
		end_else_if02:
	
	
	end_if01:

	leave

	ret
