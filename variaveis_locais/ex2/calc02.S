.text
.globl calc
calc:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	
	movq %r12, -8(%rbp) # salva r12   
	movq %r13, -16(%rbp) #salva r13
	
	movl $0, %r12d # int i = 0 
	movl $4, %r13d # int j = 4
	
	# sum -> -20(%rbp)
	# vet1 -> -40(%rbp)
	# vet2 -> -50(%rbp)
	
	# call filli
	
	leaq -40(%rbp), %rdi 
	movl $5, %esi
	movl %r12d, %edx
	
	call filli
	
	#call fills
	
	leaq -50(%rbp), %rdi
	movl $5, %esi
	movl %r13d, %edx
	
	call fills
	
	movl $0, -20(%rbp) # sum = 0
	
	for:
		cmpl $5, %r12d
		jge end_for
	
		# vet1[i]
		leaq -40(%rbp), %r8
		movslq %r12d, %r9
		imulq $4, %r9
		addq %r8, %r9
		movl (%r9), %ecx
		
		#vet1[j]
		leaq -50(%rbp), %r8
		movslq %r13d, %r9
		imulq $2, %r9
		addq %r8, %r9
		movswl (%r9), %edx
			
		addl %ecx, %edx
		addl %edx, -20(%rbp)
		
		incl %r12d
		decl %r13d
			
		jmp for
	end_for:
	
	movl -20(%rbp), %eax
	
	movq -8(%rbp), %r12 # recupera r12   
	movq -16(%rbp), %r13 #recupera r13
	
	leave
	ret
