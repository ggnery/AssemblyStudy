.data

	.globl vet
	.align 4
	vet: .int 10, 20, 10, 40, 20

.text

.globl calc
calc:
	pusq %rbp
	movq %rsp, %rbp
	
	#PARAMETROS
	# int* resp -> %rdi
	# int mark -> %esi
	
	movl $0, %ecx # int i = 0
	
	while01:
		cmpl $5, %ecx
		jge end_while01
	
		# vet[i]
		movq $vet, %r8 # &vet
		movslq %ecx, %r9 # (long) i
		imulq $4, %r9 # i *sizeof(int)
		addq %r8, %r9 # &vet[i]
		
		movl (%r9), r10d #vet[i]
		
		if01:
			cmpl %esi, %r10d
			jne else01
			
			movl %r10d, (%rdi) #*resp = vet[i]
		
			jmp end_else01
		else01:
			movl (%rdi), %esi #mark = *resp
		
		end_else01:
	
		incl %ecx #i++
				
		jmp while01
	end_while01:
	
	leave
	ret
