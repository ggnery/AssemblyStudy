.section .rodata
	
	fmt1: .string "%d: sum = %ld\n"
	fmt2: .string "retorno = %ld\n"
	
.data

	.globl v
	.align 2
	v: .word 1,2,3,4,5
	
	.globl max
	.align 2
	max: .word 0
	
.text
.globl calc
calc:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	
	movq %r12, -48(%rbp)  # short value
	movq %r13, -56(%rbp) #  int i
	movq %r14, -64(%rbp) # long sum
	
	#PARAMETROS
	#short *vet -> %rdi
	#int size -> %esi
	#int factor -> %edx
	#short *max -> %rcx
	#char option -> %r8b
	
	movl $0, %r13d #int i = 0
	movq $0, %r14 #long sum = 0
	
	while01:
		cmpl %esi, %r13d
		jge end_while01
	
		# vet[i]
		movq %rdi, %r9 # r9 = &vet
		movslq %r13d, %r10 # (long) i 
		imulq $2, %r10 # i * sizeof(short)
		addq %r9, %r10 # r10 = &vet[i]
		
		#value = vet[i]
		movw (%r10), %r12w 
		
		if01:
			cmpw %r12w, (%rcx)
			jge end_if01
			
			# *max = value
			movw %r12w, (%rcx)
			
		end_if01:
	
		# (short) factor
		movw %dx, %r9w
		
		# *max * (short)factor
		imulw (%rcx), %r9w
		
		# sum = (long)(*max * (short)factor)
		movswq %r9w, %r14
		
		#printf
		
		movq %rdi, -8(%rbp)
		movq %rsi, -16(%rbp)
		movq %rdx, -24(%rbp)
		movq %rcx, -32(%rbp)
		movq %r8, -40(%rbp)
		
		movq $fmt1, %rdi #1o param 
		movl %r13d, %esi #2o param
		movq %r14, %rdx #3o param
		movl $0, %eax # 0 pontos flutuantes
		
		incl %r13d #i++
		
		call printf
		
		movq -8(%rbp), %rdi
		movq -16(%rbp), %rsi
		movq -24(%rbp), %rdx
		movq -32(%rbp), %rcx
		movq -40(%rbp), %r8
	
		jmp while01
	end_while01:
	
	if02:
		cmpb $1, %r8b
		jne end_if02
		
		#return sum
		movq %r14 ,%rax	
			
		movq -48(%rbp), %r12  # short value
		movq -56(%rbp), %r13 #  int i
		movq -64(%rbp), %r14 # long sum
		
		leave
		ret
	
	end_if02:
	
	#return 0
	movq $0 ,%rax	
	
	movq -48(%rbp), %r12  # short value
	movq -56(%rbp), %r13 #  int i
	movq -64(%rbp), %r14 # long sum
	
	leave 
	ret
	
.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	
	movq $v, %rdi # 1o param
	movl $5, %esi # 2o param
	movl $2, %edx #3o param
	movq $max, %rcx # 4o param
	movb $1, %r8b #5o param
	
	call calc
	#retorno de calc esta em %rax
	
	movq $fmt2, %rdi # 1o param
	movq %rax, %rsi # 2o param
	movq $0, %rax # 0 pontos flutuantes
	
	call printf
	
	#return 0
	movl $0 ,%eax
	
	leave
	ret
	
