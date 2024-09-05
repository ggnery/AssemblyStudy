.section .rodata
	fmt: .string "a = %f, b = %f, e = %f\n"
.data

.text

.globl calc2
calc2:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	
	# PARAMETROS
	# float a -> %xmm0
	# float b -> %xmm1
	
	movss %xmm0, -4(%rbp)
	movss %xmm1, -8(%rbp)
	
	cvtss2sd %xmm1, %xmm0 # 1o param
	
	call cos
	
	movsd %xmm0, %xmm2 # xmm2 salva cos(b)
	
	movss -4(%rbp), %xmm0
	movss -8(%rbp), %xmm1
	
	cvtss2sd %xmm0, %xmm3 # xmm3 = (double) a
	addsd %xmm2, %xmm3
	
	#call printf
	movss %xmm0, -4(%rbp)
	movss %xmm1, -8(%rbp)
	
	cvtss2sd %xmm0, %xmm0 #1o param
	cvtss2sd %xmm1, %xmm1 #2o param
	movsd %xmm3, %xmm2 #1o param

	movl $3, %eax 
	call printf
	
	movss -4(%rbp), %xmm0
	movss -8(%rbp), %xmm1
	
	movss %xmm1, %xmm0
	
	leave 
	ret
