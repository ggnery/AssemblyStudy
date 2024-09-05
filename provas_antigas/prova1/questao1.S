.data 

	.globl vet
	.align 4
	vet: .int 10, 20, 30, 40, 50

.text

.globl calc
calc:
	pushq %rbp
	movq %rsp, %rbp
	
	# int* resp -> %rdi
	# int mark -> %esi
	
	movl $0, %ecx # int i = 0
	while:
		cmpl $5, %ecx
		jge end_while
		
		# vet[i]
 		movq $vet, %r8 # &vet
 		movslq %ecx, %r9 # (long) i
		imulq $4, %r9 # i * sizeof(int)
		addq %r8, %r9 # &vet[i] = &vet + i * sizeof(int)
		
		movl (%r9), %r10d # vet[i]
		
		if:	
			cmpl %esi, %r10d
			jne else
		
			# vet[i]
	 		movq $vet, %r8 # &vet
	 		movslq %ecx, %r9 # (long) i
			imulq $4, %r9 # i * sizeof(int)
			addq %r8, %r9 # &vet[i] = &vet + i * sizeof(int)
			
			movl (%r9), %r10d # vet[i]
			
			movl %r10d, (%rdi) # *resp = vet[i]
		
			jmp end_else
		else:
			movl (%rdi) ,%esi # mark = *resp
		
		end_else:
		
		
		incl %ecx # i++
		jmp while
	end_while:
	
	leave
	ret
