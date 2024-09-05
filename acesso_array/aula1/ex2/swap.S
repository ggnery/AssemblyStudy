.data

	.globl last
	.align 8
	last: .quad 0
	
	.globl values
	.align 8
	values: .quad 50, -10, 60, -20, 70
	
.text



.globl swap

swap:

	pushq %rbp

	movq  %rsp, %rbp



	# Seu código aqui...
	
	#int i
	movl $4, %ecx # ecx = j
	
	movl $0, %eax # i = 0
	for:
		cmpl %ecx, %eax
		jge end_for
		
		# long tmp = values[i]
		
		movq $values, %rdx # rdx = &values
		movslq %eax, %rdi # rdi = (long) i
		imulq $8 ,%rdi # rdi = i * sizeof(long) 
		addq %rdi, %rdx # &values[i] = &values + (i * sizeof(long))
		movq (%rdx), %r8 # tmp = r8 = values[i]
		
		#values[j]
		
		movq $values, %rdx # rdx = &values
		movslq %ecx, %rdi # rdi = (long) j
		imulq $8 ,%rdi # rdi = j * sizeof(long) 
		addq %rdi, %rdx # &values[j] = &values + (j * sizeof(long))
		movq (%rdx), %r9 # r9 = values[j]
		
		#values[i] = values[j]
		
		movq $values, %rdx # rdx = &values
		movslq %eax, %rdi # rdi = (long) i
		imulq $8 ,%rdi # rdi = i * sizeof(long) 
		addq %rdi, %rdx # &values[i] = &values + (i * sizeof(long))
		movq %r9, (%rdx)
		
		# values[j] = tmp
		
		movq $values, %rdx # rdx = &values
		movslq %ecx, %rdi # rdi = (long) j
		imulq $8 ,%rdi # rdi = j * sizeof(long) 
		addq %rdi, %rdx # &values[j] = &values + (j * sizeof(long))
		movq %r8, (%rdx)
		
		
		incl %eax #i++
		decl %ecx #j--
		jmp for
	end_for:
	
	#values[4]
	movq $values, %rdx # rdx = &values
	movabs $4, %rdi # rdi = (long) 4
	imulq $8, %rdi # 4 * sizeof(long)
	addq %rdx, %rdi # &values[i] = &values + (4 * sizeof(long))
	movq (%rdi), %r8 # r8 = values[i]
	movq %r8, last # last = vlaues[i]
	
	leave

	ret
