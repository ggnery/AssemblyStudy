.section .rodata

	.globl str1
	.align 1
	str1: .string "'a' maior do que 'b'\n"
	
	.globl str2
	.align 1
	str2: .string "Valor de 'b': %d\n"

.data 

	.globl a
	.align 1
	a: .byte 97


	.globl b
	.align 1
	b: .byte 105
	
.text

.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	
	# int ret = maximo(a, b)
	movb a, %dil #1o param
	movb b, %sil # 2o param
	
	call maximo
	
	movl %eax, %r9d # r9d = ret = maximo(a, b)
	
	if:
		movsbl a, %r9d # edx = (int) a
		cmpl %edx, %r9d
		jne else
		
		# printf("'a' maior do que 'b'\n")
		movq $str1, %rdi #1o param
		movl $0, %eax #0 pontos flutuantes
		
		call printf
		
		
		jmp end_else
	else:
		movsbl b, %r8d #(int) b 
		
		movq $str2, %rdi #1o param
		movl %r8d, %esi #2o param
		movl $0, %eax # 0 pontos flutuantes
		
		call printf
		
		
	end_else:
	
	
	movl $0, %eax #return 0
	leave
	ret
	
