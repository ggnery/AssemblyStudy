.section .rodata

	.globl fmt
	.align 1
	fmt: .string "Valor: x = %ld, i = %d\n"

.data

	.globl x
	.align 8
	x: .quad 10

.text
.globl aux

aux:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	
	# x = 5
	movq $5, x
	
	# printf("Valor: x = %ld, i = %d\n", x, i)
	
	movq %rdi, -8(%rbp) #salva i
	movq %rsi, -16(%rbp) # salva ptr
	
	movl %edi, %edx #3o param
	movq $fmt, %rdi # 1o param
	movq x, %rsi # 2o param
	movl $0, %eax # 0 pontos flutuantes
	
	call printf 
	
	movq -8(%rbp), %rdi #recupera i
	movq -16(%rbp), %rsi  # recupera ptr
	
	movslq %edi, %r8 #(long) i
	addq x, %r8 # x +i
	addq (%rsi), %r8 #  x + i + *ptr
	
	movq %r8, %rax # return x + i + *ptr
	
	leave
	ret
