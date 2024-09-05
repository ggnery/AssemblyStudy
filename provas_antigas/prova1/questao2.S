.data

	.globl a
	.align 8
	a: .quad 0

.text
.globl aux
aux:
	pushq %rbp
	movq %rsp, %rbp
	subq $48 ,%rsp
	
	#Parametros
	#short *ptr -> %rdi
	#int step -> %esi
	#char *fmt -> %rdx
	#char limit -> %cl
	
	movq %rdi, -8(%rbp)
	movq %rsi, -16(%rbp)
	movq %rdx, -24(%rbp)
	movq %rcx, -32(%rbp)
	
	movq %rdi, %rsi # ptr -> 2o param
	movq $a, %rdi # &a -> 1o param 
	movl $120, %edx # SIZE -> 3o param
	
	call init
	
	movq -8(%rbp), %rdi
	movq -16(%rbp), %rsi
	movq -24(%rbp), %rdx 
	movq -32(%rbp), %rcx
	
	for:
		cmpw $0, (%rdi)
		je end_for
		
		#ptr[a]
		movq %rdi, %r8 # &ptr
		movq a, %r9 # r9 = (long) a
		imulq $2, %r9 # a * sizeof(short)
		addq %r8, %r9 # r9 = &ptr[a]
		movw (%r9), %r10w # r10w = ptr[a]
		
		movb %r10b, %r11b # r11b = (char) ptr[a]
			
		if:
			cmpb %cl, %r11b
			jle else
			
			movq %rdi, -8(%rbp)
			movq %rsi, -16(%rbp)
			movq %rdx, -24(%rbp)
			movq %rcx, -32(%rbp)
			
			movw (%rdi), %si #2o param
			movq %rdx, %rdi #1o param
			
			call printf
			
			movq -8(%rbp), %rdi
			movq -16(%rbp), %rsi
			movq -24(%rbp), %rdx 
			movq -32(%rbp), %rcx
					
			jmp end_else
		else:
			movl $5, %r8d # int i = 5
			
			while:	
				cmpl %esi, $r8d
				jle end_while
				
				movslq %r8d, %r9 # (long)i
				addq %r9, a # a = a + i
				
				movq %rdi, -8(%rbp)
				movq %rsi, -16(%rbp)
				movq %rdx, -24(%rbp)
				movq %rcx, -32(%rbp)
				movq %r8d, -40(%rbp)
				
				movq $a, %rdi #1o param
				
				call escape
				
				movq -8(%rbp), %rdi
				movq -16(%rbp), %rsi
				movq -24(%rbp), %rdx 
				movq -32(%rbp), %rcx
				movq -40(%rbp), %r8d
				
				jmp while
			end_while:
		
		
		end_else:
		
		addq $2 ,%rdi #ptr++	
	end_for:
	
	#return (int) a
	movq a, %r11
	movl %r11 , %eax
	
	leave 
	ret
