.section .rodata
	fmt: .string "Diferença em %d/%d: %ld\n"
.data

	.globl prods
	.align 8
	prods: .zero 48

.text
.globl media
media:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	
	movq %r12, -8(%rbp)
	movq %r13, -16(%rbp)
	
	movl $0, %r12d
	movq $0, %r13
	
	movl $0, %r12d
	for01:
		movslq %r12d, %rax
		cmpq %rsi, %rax
		jge endfor01
		
		movslq %r12d, %rax
		imulq $24, %rax
		addq %rdi, %rax
		
		addq 8(%rax), %r13
	
		incl %r12d
		jmp for01
	endfor01:

	movq %r13, %rax	
	cqto
	idivq %rsi
	
	movq -16(%rbp), %r13
	movq -8(%rbp), %r12
	
	leave
	ret

.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $16, %rsp
	
	movl $0, %r8d #int i = 0
	
	movq $prods, %r10 # r10 = &prods[0]
	movb $1, (%r10) # prods[0].mes = 1
	movq $100, 8(%r10) # prods[0].preco = 100
	movl $2020, 16(%r10) # prods[0].ano = 2020
	
	addq $24, %r10 # r10 = &prods[1]
	
	movb $2, (%r10) # prods[0].mes = 2
	movq $120, 8(%r10) # prods[0].preco = 120
	movl $2020, 16(%r10) # prods[0].ano = 2020
	
	# media(prods, SIZE)
	movq %r8, -8(%rbp) # salvo i
	
	movq $prods, %rdi #1o param
	movq $2, %rsi # 2o param
	
	call media
	
	movq -8(%rbp), %r8 # recupero i
	
	movq %rax, %r9 # r9 = long m = media(prods, SIZE)
	
	while:
		cmpl $2, %r8d
		jge end_while
		
		# call printf
		movq %r8, -8(%rbp) # salvo i
		movq %r9, -16(%rbp) #salvo m
		
		movq $fmt, %rdi #1o param
		
		# &prods[i]
		movq $prods, %r10 # r10 = &prods
		movslq %r8d, %r11 # r11 = (long) i
		imulq $24 ,%r11 # i * sizeof(Produto)
		addq %r10 ,%r11 # r11 = &prods[i]
			
		movsbl (%r11), %esi #2o param
		movl 16(%r11), %edx #3o param
		
		movq 8(%r11), %rcx
		subq %r9, %rcx # 4o param
		
		call printf
		
		movq -8(%rbp), %r8 # recupero i
		movq -16(%rbp), %r9 #recupero m
		
		incl %r8d # i++
		jmp while
	end_while:
	
	movl $0, %eax # return 0
	
	leave 
	ret



























