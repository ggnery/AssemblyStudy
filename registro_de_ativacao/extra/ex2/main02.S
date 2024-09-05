.section .rodata
		
	.globl fmt
	.align 1
	fmt: .string "Result 0x%X\n"

.data
	
	.globl result
	.align 4
	result: .int 0
	
	.globl values
	.align 1
	values: .byte 10, 20, 30, 40
	
	.globl bases
	.align 8
	bases: .quad 0xAA0000, 0xBB0000, 0xCC0000, 0xDD0000

.text

.globl imerge
imerge:
	pushq %rbp
	movq %rsp, %rbp
	
	# int x -> %edi
	# char y -> %sil
	
	# x | y
	movsbl %sil, %r8d
	orl %edi , %r8d
	
	# return x | y
	movl %r8d, %eax
	
	leave
	ret

.globl lmerge
lmerge:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	# long a -> %rdi
	# char b -> %sil
	
	movsbl %sil, %r8d #(int) b
	shll $8, %r8d # (int)b << 8
	
	movl %edi, %r9d # (int)a
	
	orl %r9d, %r8d # tmp = r8d = (int)a | ( (int)b << 8 )
	
	movq %rdi, -8(%rbp) # salva a
	movq %rsi, -16(%rbp) # salva b
	movq %r8, -24(%rbp) # salva tmp
	
	movl %r8d, %edi #1o param (tmp)
	# sil = 2o param (b)
	
	call imerge
	
	movq -8(%rbp), %rdi # recupera a
	movq -16(%rbp), %rsi # recupera b
	movq -24(%rbp), %r8 # recupera tmp
	
	movslq %eax, %r9 # (long) return imerge
	orq %rdi, %r9 # a | imerge(tmp, b)
	
	movq %r9, %rax #return lmerge
	
	leave
	ret
	
.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	
	movq %r12, -8(%rbp) #salva i
	movq %r13, -16(%rbp) # salva j
	
	
	movl $0, %r12d #int i = 0
	movl $3, %r13d #int j = 0
	for:
		cmpl $4, %r12d
		jge end_for
		
		#=========================================
		#result = (int)lmerge(bases[i], values[j]);
		# ===================================== 
		
		
		#bases[i]
		movq $bases, %r8 # &bases
		movslq %r12d, %r9 # (long) i
		imulq $8 ,%r9 # i * sizeof(long)
		addq %r8 ,%r9 # &bases[i]
		movq (%r9), %rdi # 1o param (long a) 
		
		#values[j]
		movq $values, %r8 # &values
		movslq %r13d, %r9 # (long) j
		imulq $1 ,%r9 # j * sizeof(char)
		addq %r8 ,%r9 # &values[j]
		movb (%r9), %sil # 2o param (char b) 
		
		call lmerge
		
		movl %eax, result # result = (int)lmerge(bases[i], values[j])
		
		
		#=========================================
		# printf("Result 0x%X\n", result)
		#===================================== 
		
		
		movq $fmt, %rdi # 1o param
		movl result, %esi #2o param
		movl $0, %eax # 0 pontos flutuantes
		
		call printf
		
		
		incl %r12d #i++ 
		decl %r13d #j--
		jmp for
	end_for:
	
	movl $0, %eax #return 0
	
	movq -8(%rbp), %r12  # recupera i
	movq -16(%rbp), %r13 # recupera j
	
	leave
	ret

