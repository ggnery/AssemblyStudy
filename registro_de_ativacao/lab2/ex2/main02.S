.data

	.globl v1
	.align 2
	v1: .word 1, 2
	
	.globl v2
	.align 8
	v2: .long 1, 2, 3	

.text

.globl aux
aux:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	
	movl $2, %ecx # int i = 2
	for:		
		cmpl $0, %ecx
		jl end_for
		
		movq %rcx, -8(%rbp) #salva i
		movq %rdi, -16(%rbp) #salva a1
		movq %rsi, -24(%rbp) #salva p1
		
		# rdi = a1 ja é o 1o param
		# esi = p1 ja é o 2o param
		movq $v2, %rdx #3o param
		#ecx = i ja é o 4o param
		
		call sum
		
		movq -8(%rbp), %rcx #salva i
		movq -16(%rbp), %rdi #salva a1
		movq -24(%rbp), %rsi #salva p1
		
		
		decl %ecx # i--
		jmp for
	end_for:
	
	leave 
	ret

.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	
	movl $0, %ecx # int i = 0	
	while:
		cmpl $2, %ecx
		jge end_while
		
		movq %rcx, -8(%rbp) #salva i
		
		movq $v1, %rdi #1o param
		movl %ecx, %esi #2o param
		
		call aux
		
		movq -8(%rbp), %rcx #recupera i
		incl %ecx # i++
		
		jmp while
	end_while:
		
	movl $0, %eax
	
	leave
	ret
	

