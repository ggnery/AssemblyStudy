.section .rodata

	.globl fmt 
	.align 1
	fmt: .string "Iteração %d, v = %d\n"

.data

	.globl i
	.align 4
	i: .int 0
	
	.globl v
	.align 2
	v: .word 0
	
	.globl vetA
	.align 2
	vetA: .word 28, 42, 16, 23, 47
	
	.globl vetB
	.align 4
	vetB: .int 0, 0, 0, 0, 0

.text
.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	
	while:
		cmpl $5, i
		jge end_while
	
		# vetA[i]
		movq $vetA, %r8 # &vetA
		movslq i, %r9 # (long) i
		imulq $2, %r9 # i * sizeof(short)
		addq %r8, %r9 # &vetA[i] = &vetA + (i * sizeof(short))
		movw (%r9), %r10w # vetA[i]
		
		shlw $2, %r10w #vetA[i] << 2
		
		movw %r10w, v #v = vetA[i] << 2
	
		# printf("Iteração %d, v = %d\n", i, (int)v)
		movq $fmt, %rdi #1o param
		movl i, %esi #2o param
		movswl v, %edx #3o param
		movl $0, %eax # 0 pontos flutuantes
		
		call printf
		
		# vetB[i]
		movq $vetB, %r8 # &vetB
		movslq i, %r9 # (long) i
		imulq $4, %r9 # i * sizeof(int)
		addq %r8, %r9 # &vetB[i] = &vetB + (i * sizeof(int))
	
		movl i, %edi #1o param
		movw v, %si #2o param
		movq %r9, %rdx #3o param
			
		call process	
			
		incl i # i++ 
		jmp while
	end_while:
	
	movq $vetB, %rdi #1o param
	movq $5, %rsi #2o param
	
	call show

	movl $0, %eax # return 0
	
	leave 
	ret
