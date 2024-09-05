.data



	.globl	v1

	.align	2

v1: .short 1,2





	.globl v2

	.align 8

v2: .quad 1, 2, 3



#---------------------------------------------------------------------



	.text



	.globl aux

aux:

	pushq %rbp

	movq %rsp, %rbp

	subq $32, %rsp			# alinhado 16 (multiplo 16)



	# 1o. param -> rdi

	# 2o. param -> esi



	# int i

	# i -> %ecx



	# for (i = 2; i >= 0; i--)

	movl $2, %ecx # i = 2

begin_for01:

	cmpl $0, %ecx			# if (i < 0) -> end

	jl end_for01



	movq %rdi,  -8(%rbp)		# Salvando rdi (caller-saved)

	movq %rsi, -16(%rbp)		# Salvando rsi (caller-saved)

	movq %rcx, -24(%rbp)		# Salvando rcx (caller-saved)



	# 1o. param rdi

	# 2o. param esi

	# 4o. param ecx

	movq $v2, %rdx			# 3o. param

	call sum



	movq  -8(%rbp), %rdi		# Recuperando rdi

	movq -16(%rbp), %rsi		# Recuperando rsi

	movq -24(%rbp), %rcx		# Recuperando rcx



	decl %ecx		# i--



	jmp begin_for01

end_for01:

	leave

	ret



#-------------------------------------------------------------------------------



	.globl main

main:

	pushq %rbp

	movq %rsp, %rbp



	subq $16, %rsp



	# int i = 0

	movl $0, %ecx			# ecx = i = 0



	# while (i < 2)

begin_while01:

	cmpl $2, %ecx			# if (i >= 2) -> end

	jge end_while01



	movq %rcx, -8(%rbp)		# Salvando rcx (caller-saved)



	movq $v1, %rdi			# 1o. param

	movl %ecx, %esi			# 2o. param

	call aux



	movq -8(%rbp), %rcx		# Recuperando rcx



	incl %ecx			# i++



	jmp begin_while01

end_while01:

	leave

	ret
