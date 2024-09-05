.section .rodata

.data

	.globl i
	.align 4
	i: .int 0

	.globl bias
	.align 8
	bias: .quad 256

	.globl vet
	.align 1
	vet: .byte 12, 3, 20, 8

.text

.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	
	movl $0, i # i = 0
	for:
		cmpl $4, i
		jge end_for
		
		# vet[i]
		movq $vet, %rax # &vet
		movslq i, %rdx # (long) i
		imulq $1, %rdx # i * sizeof(char)
		addq %rax, %rdx # &vet[i] = &vet + (i * sizeof(char))
		
		movb (%rdx), %dil #1o param
		movw $10, %si #2o param
		movq bias, %rdx #3o param
		
		call filtro
		
		movq %rax, bias # bias = filtro(vet[i], LIM, bias)
		
		incl i # i++
		jmp for
	end_for:
	
	movl $0, %eax # return 0
	leave 
	ret
