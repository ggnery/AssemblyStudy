.section .rodata
	
	fmt: .string "Soma %f maior que o limite %f (%d)\n"
	
	.align 8
	tmp01: .double 0.0
	
.text
.globl sum
sum:
	pushq %rbp
	movq %rsp, %rbp
	subq $80, %rsp
	
	#PARAMTROS
	#double limit -> %xmm0
	
	movl $4, %ecx # ecx = int i = 4
	movsd tmp01, %xmm1 # xmm1 = s = 0.0 
	
	# int vi[4] = {5,6,7,8}
	movq $5, -72(%rbp) 
	movq $6, -68(%rbp)
	movq $7, -64(%rbp)
	movq $6, -60(%rbp)
	
	# mult(vi, vd, i)
	
	movq %xmm0, -8(%rbp) #salva limit
	movq %xmm1, -16(%rbp) #salva s
	movq %rcx, -56(%rbp) #salva i
	
	leaq -72(%rbp), %rdi #1o parametro
	leaq -48(%rbp), %rsi #2o parametro
	movl %ecx, %ecx #3o parametro
	
	call mult
	
	movq -8(%rbp), %xmm0 #recupera limit
	movq -16(%rbp), %xmm1 #recupera s
	movq -56(%rbp), %rcx #recupera i
	
	while:
		cmpl $0, %ecx
		jle end_while
	
		#vd[--i]
		decl %ecx #i--
		
		leaq -48(%rbp), %r8 # &vd[0]
		movslq %ecx, %r9 # (long) i
		imulq $8, %r9 # i * sizeof(double)
		addq %r8, %r9 # &vd[--i]
		
		addsd (%r9), %xmm1 # s += vd[--i]
		
		if:
			ucomisd %xmm0 , %xmm1
			jp end_if
			jbe end_if
			
			#call printf
			movq %xmm0, -8(%rbp) #salva limit
			movq %xmm1, -16(%rbp) #salva s
			movq %rcx, -56(%rbp) #salva i
					
			movq $fmt, %rdi # 1o parametro
			
			movsd %xmm0, %xmm2 
			movsd %xmm1, %xmm0 #2o parametro
			
			movsd %xmm2, %xmm1 # 3o parametro
			movl %ecx, %esi #4o parametro
			
			movl $2, %eax
			
			call printf
			
			movq -8(%rbp), %xmm0 #recupera limit
			movq -16(%rbp), %xmm1 #recupera s
			movq -56(%rbp), %rcx #recupera i
		
		end_if:
	
		jmp while
	end_while:
	
	
	movsd %xmm1, %xmm0 #return s
	
	leave
	ret
