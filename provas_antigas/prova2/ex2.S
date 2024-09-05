.section .rodata
	fmt: .string "i = %d, sum = %d\n"
.data
	
	.globl max
	.align 4
	max: .int 256
	
	.globl lim
	.align 2
	lim: .word -3
	
	.globl timer
	.align 1
	timer: .byte 100
	
	.globl vet1
	.align 8
	vet1: .quad 1, 0, 2, 3, 4
	
	.globl vet2
	.align 4
	vet2: .int 0, 0, 0, 0, 0, 
	
.text
.globl modify
modify:
	pushq %rbp
	movq %rsp, %rbo
	subq $32, %rsp
	
	movq %r12, -32(%rbp) 
	
	#PARAMETROS
	# int *v1 -> %rdi
	# long *v2 -> %rsi
	# char value -> %dl
	
	movq %rdi, -8(%rbp)
	movq %rsi, -16(%rbp)
	movq %rdx, -24(%rbp)
	
	movq %rsi, %r8
	movq %r8, %rdi #1o param (v2)
	movq %rdi, %rsi #2o param (v1)
	
	call calc
	#resultado esta em %ah
	
	movq -8(%rbp), %rdi 
	movq -16(%rbp), %rsi 
	movq -24(%rbp), %rdx 
	
	while01:
		cmpb %ah, %dl
		jle end_while01
		
		movq %rdi, -8(%rbp)
		movq %rsi, -16(%rbp)
		movq %rdx, -32(%rbp)
		
		movq %rdi, %rdx #3o param
		movl max, %edi #1o param
		movw lim, %si #2o param
		
		call complex
		#retorno esta em %rax
		
		movq -8(%rbp), %rdi 
		movq -16(%rbp), %rsi 
		movq -24(%rbp), %rdx 
		
		movq %rax, %r12 #index = complex()
		jmp while	
	end_while01:
	
	# v2[index]
	movq %rsi, %r8 # &v2
	movq %r12, %r9 # (long) index
	imulq $8 ,%r9 # index * sizeof(long)
	addq %r8, %r9 # &v2[index]
	movw (%r9), %r10 # v2[index]
	
	# v1[v2[index]]
	movq %rdi, %r8 # &v1
	movq %r10, %r9 # (long) v2[index]
	imulq $4, %r9 # v2[index] * sizeof(int)
	addq %r8, %r9 # &v1[v2[index]]
	
	#(int) value
	movsbl %dl, %r11d
	
	# v1[v2[index]] = (int) value
	movl %r11d, (%r9)
	
	movq -32(%rbp), %r12  
	leave 
	ret

.globl basic
basic:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	
	#PARAMETROS
	# int sum -> %edi
	
	movq $vet1, %r8 # ptr 
	
	(int) timer
	movbl timer %r9d
	
	while02:
		cmpl %r9d, %edi
		jge end_while02
		
		if01:
			cmpl $13, %edi
			jne end_if01
			
			jmp end_while02 # break
		
		end_if01:
	
			
		movl $0, %ecx #int i = 0
		for01:
			cmpl $10, %ecx
			jge end_for01
			
			movq %rdi, -8(%rbp) # salva sum
			movq %r8, -16(%rbp) # salva ptr
			movq %rcx, -24(%rbp) # salva i
			
			movl %edi, %edx #3o param
			movq $fmt, %rdi #1o param
			movl %ecx, %esi #2o param
			movl $0, %eax
			
			call printf
			
			movq -8(%rbp), %rdi # salva sum
			movq -16(%rbp), %r8 # salva ptr
			movq -24(%rbp), %rcx # salva i
			
			incl %ecx #i++
			jmp for01
		end_for01:
		
		movq %rdi, -8(%rbp) # salva sum
		movq %r8, -16(%rbp) # salva ptr
		
		movq $vet2, %rdi #1o param
		movq %r9, %rsi #2o param
		movb timer, %dl #3o param
		
		call modify
		
		movq -8(%rbp), %rdi # salva sum
		movq -16(%rbp), %r8 # salva ptr
	
		addq $8, %r8 # ptr++
	
		jmp while02
	end_while02:
	
	leave
	ret
	

