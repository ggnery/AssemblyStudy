.data
	.globl a
	.align 8
	a: .quad 0
	
.text

.globl aux
aux:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	
	movq %r12 ,-40(%rbp) 
	
	#PARAMETROS
	#short* ptr -> %rdi
	#int step -> %esi
	#char* fmt -> %rdx
	#char limit -> %cl
	
	# chamando init(&a, ptr, SIZE)	
	
	movq %rdi, -8(%rbp)
	movq %rsi, -16(%rbp)
	movq %rdx, -24(%rbp)
	movq %rcx, -32(%rbp)
	
	movq %rdi, %rsi #2o parametro
	movq $a, %rdi #1o parametro
	movl $120, %edx #3o parametro
	
	call init
	
	movq -8(%rbp), %rdi
	movq -16(%rbp), %rsi
	movq -24(%rbp), %rdx
	movq -32(%rbp), %rcx
	
	for:
		cmpw $0, (%rdi)
		je end_for 
		
		#(char) ptr[a]
		movq %rdi, %r8 # &ptr
		movq a, %r9 # (long) a
		imulq $2, %r9 # a * sizeof(short)
		addq %r8, %r9 # &ptr[a]
		
		movw (%r9), %r10w # ptr[a]
		movb %r10w, %r11b # (char) ptr[a]
		
		if:
			cmpb %cl, %r11b
			jle else
			
			# chamando printf(fmt, *ptr)
			
			movq %rdi, -8(%rbp)
			movq %rsi, -16(%rbp)
			movq %rdx, -24(%rbp)
			movq %rcx, -32(%rbp)
			
			movw (%rdi), %si #2o parametro
			movq %rdx, %rdi #1o parametro
			movl $0, %eax # 0 pontos flutuantes
			
			call printf
			
			movq -8(%rbp), %rdi
			movq -16(%rbp), %rsi
			movq -24(%rbp), %rdx
			movq -32(%rbp), %rcx
			
			jmp end_else
		else:
			movl $5, %r12d # int i = 5
			
			while:
				cmpl %esi, %r12d
				jle end_while
				
				# (long) i
				movslq %r12d, %r8d 
				
				# a = a + i
				addq %r8d, a
				
				# chamando escape(&a)
				movq %rdi, -8(%rbp)
				movq %rsi, -16(%rbp)
				movq %rdx, -24(%rbp)
				movq %rcx, -32(%rbp)
				
				movq $a, %rci # 1o parametro
				
				call escape
				
				movq -8(%rbp), %rdi
				movq -16(%rbp), %rsi
				movq -24(%rbp), %rdx
				movq -32(%rbp), %rcx
					
				jmp while
			end_while:
		
		end_else:
		
		addq $2, %rdi # ptr++ ???
		jmp for
	end_for:
	
	#return (int)a
	movq a, %r8
	movl %r8d, %eax
	
	movq -40(%rbp), %r12 
	
	leave
	ret
