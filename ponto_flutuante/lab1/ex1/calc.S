.text

.globl calc
calc:
	pushq %rbp
	movq %rsp, %rbp
	
	# a + b
	cvtss2sd %xmm1, %xmm2 # (double) b
	addsd %xmm0, %xmm2
	
	# a - b
	cvtss2sd %xmm1, %xmm1 # b = (double) b
	subsd %xmm1, %xmm0
	
	mulsd %xmm2, %xmm1
	
	movsd %smm1, %xmm0
	
	leave 
	ret
