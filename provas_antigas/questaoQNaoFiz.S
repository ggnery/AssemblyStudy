.data

	.globl vet
	.align 4
	vet: .int 10, 20, 10, 40, 20

.text
.globl process
process:
	pushq %rbp
	movq %rsp, %rbp
	
	#PARAMETROS
	# short factor -> %di
	# int* resp -> %rsi
	# int mark -> %edx
	
	movl $0, %ecx # int i = 0
	
	while:
		cmpl $5, %ecx
		jge while
		
		# vet[i]
		movq $vet, %r8 # &vet
		movslq %ecx, %r9 # (long) i
		imulq $4, %r9 # i * sizeof(int)
		addq %r8, %r9 # &vet[i]
		
		if:
			cmpl %edx, (%r9)
			jne else
		
			# *resp = vet[i] + (int)factor
				
			movswl %dl, %r8d # (int)factor
			addl (%r9), %r8d # vet[i] + factor
			movl %r8d, (%rsi)
				
			# factor = (short)(mark + *resp)
			movl %edx, %r8d
			addl (%rsi), %r8d
			movw %r8w, %di
				
			jmp end_else
		else:
			# mark = *resp
			
			movl (%rsi), %edx
		end_else:	
		
		incl %ecx # i++
		jmp while
	end_while:
	
	leave
	ret
