.section .rodata



fmt: .string "Soma: %ld\n"



.data



# Definição das variáveis aqui...
.globl sum
.align 8
sum: .quad 0

.globl vet
.align 8
vet: .quad 10, 20, 30, 40, 50


.text


.globl main

main:

	pushq %rbp

	movq  %rsp, %rbp



	# Inicializações de 'i' e 'ptr' aqui
	movl $0, %ecx
	movq $vet, %r8
	
	# Obs: utilize %ecx para 'i' e %r8 para 'ptr'



beginwhile:

	cmpl $5, %ecx 

	jge  endwhile      # while() {
	


	# Bloco do while aqui...
	movq sum, %rax
	addq (%r8), %rax # sum = sum + *ptr
	movq %rax, sum 
	
	addq $8, %r8 #ptr++
	incl %ecx #i++


	jmp beginwhile     # }

endwhile:



   movq $fmt, %rdi    # printf()

   movq sum, %rsi

   movl $0, %eax

   call printf



   movl $0, %eax      # return 0

   leave

   ret
