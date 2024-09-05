.section .rodata
	
	fmt: .string "%ld\n"

.text
.globl show
show:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	
	#PARAMTEROS
	# struct data *d -> %rdi 
	
	# int i esta em %ecx 
	
	movq %rdi, %rdx
	addq $8, %rdx # rdx = long *ptr = d->elems
	
	movl $0, %ecx # i = 0
	for01:
		cmpl (%rdi), %ecx
		jge endfor01
		
		# chamando printf
		movq %rdi, -8(%rbp) # salvo d
		movq %rcx, -16(%rbp) # salvo i
		movq %rdx, -24(%rbp) # salvo ptr
		
		
		movq $fmt, %rdi #1o param

		# ptr[i]
		movq %rdx, %r8 # r8 = ptr
		movslq %ecx, %r9 # (long) i 
		imulq $8, %r9 # i *sizeof(long)
		addq %r8 ,%r9 # &ptr[i] = ptr + i *sizeof(long)
		
		
		movq (%r9), %rsi #2o param
		movl $0, %eax #0 pontos flutuantes
		
		call printf
		
		movq -8(%rbp), %rdi # salvo d
		movq -16(%rbp), %rcx # salvo i
		movq -24(%rbp), %rdx # salvo ptr
		
		
		incl %ecx #i++
		jmp for01
	endfor01:
	
	
	leave
	ret
	
