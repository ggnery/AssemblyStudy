.section .rodata

	fmt: .string "Soma: %ld\n"

.text
.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	subq $, %rsp
	
	# short s = %r8w
	# long l -> -8(%rbp)
	# int i -> -20(%rbp)
	
	# chamando (short)constante()
	
	movq %r8, -16(%rbp)
	
	call constante
	
	movq -16(%rbp), %r8 
	movsbw %al, %r8w # s = (short)constante() 
		
	#call init(s, &l, &i)
	movq %r8, -16(%rbp)
	
	movw %r8w, %di # 1o param (s)
	leaq -8(%rbp), %rsi #2o param (&l)
	leaq -20(%rbp), %rdx # 3o param (&i)
	
	call init
	
	movq -16(%rbp), %r8 
	
	#call printf
	
	movq %r8, -16(%rbp)
	
	movq $fmt, %rdi # 1o param
	
	#  l + i + s
	movswq %r8w, %r9 # extendo o s
	movslq -20(%rbp), %rsi # extendo o i
	addq %r9, %rsi # rsi = s + i 
	addq -8(%rbp), %rsi # 3o param = l + s + i
	
	movl $0, %eax # 0 opntos flutuantes
	
	call printf
	
	movq -16(%rbp), %r8 
	
	movl $0, %eax #return 0
	
	leave 
	ret
