.data

.text
.globl process

process:
	pushq %rbp
	movq %rbp, %rsp
	subq $48, %rsp
	
	movq %rdi , -8(%rbp) #a
	movq %rsi, -16(%rbp) #b
	movq %rdx, -24(%rbp) #c
	movq %rcx, -32(%rbp) #d
	movq %r8, -40(%rbp) #e
	movq %r9, -48(%rbp) #f
	

	#1o param
	movq -48(%rbp), %r10  #f
	movl %r10d, %edi 
	
	#2o param
	movq -40(%rbp), %r10 #e
	movl %r10d, %esi 
	
	#3o param
	movq -32(%rbp), %r10 #d 
	movl %r10d, %edx 
	
	#4o param
	movq -24(%rbp), %r10 #c
	movl %r10d, %ecx 
	
	#5o param
	movq -16(%rbp), %r10 #b 
	movl %r10d, %r8d 
	
	#6o param
	movq -8(%rbp), %r10 #a 
	movl %r10d, %r9d 
	
	call calc
	
	movq -8(%rbp), %rdi
	movq -16(%rbp), %rsi
	movq -24(%rbp), %rdx
	movq -32(%rbp), %rcx
	movq -40(%rbp), %r8
	movq -48(%rbp), %r9
	
	#return r + a + b + c + d + e + f
	addl %edi, %eax
	addl %esi, %eax
	addl %edx, %eax
	addl %ecx, %eax
	addl %r8d, %eax
	addl %r9d, %eax 
	
	leave 
	ret




	
