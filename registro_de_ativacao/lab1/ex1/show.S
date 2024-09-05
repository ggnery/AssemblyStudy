.section .rodata

	.globl fmt
	.align 1
	fmt: .string "%d\n"
.data

.text
.globl show
show:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	
	#  for (i = 0; i < size; i++)
	movl $0, %ecx # int i = 0
	for:	
		cmpl %esi, %ecx
		jge end_for
		
		#printf("%d\n", v[i])
		
		movq %rdi, -8(%rbp) # savla &v
		movq %rsi, -16(%rbp) # salva size
		movq %rcx, -24(%rbp) # salva i
		
		# v[i]
		movq %rdi, %r8 # &v
		movslq %ecx, %r9 #(long) i
		imulq $4, %r9 # i * sizeof(int)
		addq %r8, %r9 # &v[i] = &v +(i * sizeof(int))
		movl (%r9), %r10d # v[i]
		
		movq $fmt, %rdi #1o param
		movl %r10d, %esi #2o param
		movl $0, %ecx # 0 pontos flutuantes
		
		call printf
		
		movq -8(%rbp), %rdi # recupera &v
		movq -16(%rbp), %rsi  # recupera size
		movq -24(%rbp), %rcx # recupera i
			
		incl %ecx # i++
		jmp for
	end_for:
	
	leave 
	ret
	


