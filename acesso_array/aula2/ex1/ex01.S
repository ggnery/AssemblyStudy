.section .rodata

.data

	.globl vet 
	.align 2
	vet: .word 50, 10, 67, 42
	
	.globl max
	.align 2 
	max: .word 0	

.text

.globl ex01

ex01:
	pushq %rbp
	movq %rsp, %rbp
	
	#char i
	movw $0, %cx # ax = i = 0 
	for:
		cmpw $4, %cx
		jge end_for
		
		# vet[i]
		movq $vet, %rax
		movswq %cx, %rdx # rdx = (long) i
		imulq $2, %rdx # i * sizeof(short)
		addq %rdx, %rax # rax = &vet + (i * sizeof(short))
		movw (%rax), %r8w # r8w = vet[i]
		
		if:
			cmpw max, %r8w
			jle end_if
			
			movw %r8w, max 
			
		end_if:
		
		incw %cx #i++
		jmp for
	end_for:
	
	leave
	ret
