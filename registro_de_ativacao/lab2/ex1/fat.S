.data

.text

.globl fat
fat:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	
	if:
		cmpl $0, %edi
		jle end_if
		
			movq %rdi, -8(%rbp) #salva n
			
			decl %edi # n - 1
			call fat
			
			movq -8(%rbp), %rdi #recupera n
			
			imull %edi, %eax
			leave 
			ret
	end_if:	
		movl $1, %eax
	
	leave 
	ret
