        .section .rodata

	

        .data
	
	.globl v1
	.align 2
	v1: .word 32, 34, 27, 4

	.globl v2
	.align 4
	v2: .int 12, 22, 31, 23, 6
	
	.globl v3
	v3: .byte 0, 0, 0, 0
	
	.globl v4
	.align 8
	v4: .quad 0, 0, 0, 0, 0, 0, 0, 0
	
	.globl i
	.align 4
	i: .int 0
	
	.globl j
	.align 2
	j: .word 0

        .text

        .globl aux

aux:

        pushq %rbp

        movq  %rsp, %rbp

        # Seu código aqui...

	# i = 0
	movl $0, i # i = 0
	for:
		cmpl $4, i
		jge end_for
		
		movw $0, j # j = 0
		
		while:
			cmpw $5, j
			jge end_while
			
			if:
				movswl j, %eax # eax = (int) j
				cmpl %eax, i
				jne else
			
				#v1[i]
				movq $v1, %rax # rax = &v1
				movslq i, %rcx # rcx = (long) i
				imulq $2, %rcx # rcx = i * sizeof(short)
				addq %rcx, %rax # rax = &v1[i] = &v1 + (i * sizeof(short))
				movw (%rax), %r8w # r8w = v1[i]
				
				#v2[j]
				movq $v2, %rax # rax = &v2
				movslq j, %rcx # rcx = (long) j
				imulq $4, %rcx # rcx = i * sizeof(int)
				addq %rcx, %rax # rax = &v2[j] = &v2 + (j * sizeof(int))
				movl (%rax), %r9d # r9d = v2[j]
				
				#v1[i] + v2[j]
				movswl %r8w, %edi 
				addl %r9d, %edi # edi = v1[i] + v2[j]
				
				#v3[i]	
				movq $v3, %rax # rax = &v3
				movslq i, %rcx # rcx = (long) i
				imulq $1, %rcx # rcx = i * sizeof(char)
				addq %rcx, %rax # rax = &v3[i] = &v3 + (i * sizeof(char))
				
				# v3[i] = v1[i] + v2[j]
				movb %dil, (%rax)
					
				jmp end_else
			else:
			
				#v1[i]
				movq $v1, %rax # rax = &v1
				movslq i, %rcx # rcx = (long) i
				imulq $2, %rcx # rcx = i * sizeof(short)
				addq %rcx, %rax # rax = &v1[i] = &v1 + (i * sizeof(short))
				movw (%rax), %r8w # r8w = v1[i]
				
				#v2[j]
				movq $v2, %rax # rax = &v2
				movslq j, %rcx # rcx = (long) j
				imulq $4, %rcx # rcx = i * sizeof(int)
				addq %rcx, %rax # rax = &v2[j] = &v2 + (j * sizeof(int))
				movl (%rax), %r9d # r9d = v2[j]
				
				#v1[i] + v2[j]
				movswl %r8w, %edi 
				addl %r9d, %edi # edi = v1[i] + v2[j]
				
				# i + j
				movswl j, %ecx
				addl i, %ecx # ecx = i + j
				
				# v4[i + j]
				movq $v4, %rax # rax = &v4
				movslq %ecx, %rdx # rdx = (long) i+j
				imulq $8, %rdx # ((long) i+j) * sizeof(long)
				addq %rdx, %rax # rax = &v4[i+j] = &v4 + ((long) i+j) * sizeof(long)
				
				#v4[i + j] += v1[i] + v2[j]
				movslq %edi, %rsi # rsi = (long) v1[i] + v2[j]
				addq %rsi, (%rax) # v4[i + j] += v1[i] + v2[j]
				
			end_else:
			
			incw j # j++
			
			jmp while
		end_while:
		
		incl i #i++
		jmp for
	end_for:	

        leave

        ret
