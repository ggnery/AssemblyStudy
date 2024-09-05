.section .rodata

	fmt: .string "color: %ld, filled: %d\n"

.data
	
	.globl c1
	.align 8
	c1: .zero 24 
			

.text
.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	
	movq $c1, %r8 # r8 = &c1
	
	# c1.x = 10
	movl $10, (%r8) 
	
	# 2 * c1.x
	movl (%r8), %r10d
	imull $2, %r10d # r10 = 2 * c1.x
	
	#c1.y = 2 * c1.x
	movl %r10d, 4(%r8)
	
	#c1.filled = 1
	movb $1, 8(%r8)
	
	if01:
		cmpl $15, 4(%r8)
		jle else 
		
		movq $2, 16(%r8) # c1.color = RED
		
		jmp end_if01
	else:
			
		movq $1, 16(%r8) # c1.color = BLUE
	
	end_if01:
	
	#chamando printf
	movq $fmt, %rdi #1o param
	movq 16(%r8), %rsi # 2o param
	movsbl 8(%r8), %edx #3o param

	movl $0, %eax #0 pontos flutuantes
	
	call printf
	
	movl $0, %eax #return 0
	
	leave 
	ret
	
