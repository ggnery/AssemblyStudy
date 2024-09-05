.section .rodata

	.globl str
	.align 1
	str: .string "Hello"

.data

	.globl val
	.align 4
	val: .int 432

	.globl age
	.align 2
	age: .word 4

	.globl r
	.align 4
	r: .int 0

	.globl err
	.align 8
	err: .quad 2048

.text

.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	
	movq $str, %rdi #1o param
	movl val, %esi #2o param
	movw age, %dx #3o param
	movq $r, %rcx #4o param
	
	call sum
	 
	movl %eax, val # val = sum("Hello", val, age, &r)
	
	movq err, %rdi #1o param
	movl val, %esi #2o param
	movl r, %edx #3o param
	
	call show
	
	movl $0, %eax #return 0
	leave
	ret
