.section .rodata

	.globl fmt
	.align 1
	fmt: .string "%s\n"

.data
	.globl str
	.align 1
	str: .string "beba muito mais cafe"
.text

.globl process
process:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	
	# str -> rdi
	# size -> rsi
	# v -> dl	 
		
	movq $0, %rcx # i = 0
	
	# while (i < size)
	while:
		cmpq %rsi, %rcx
		jge end_while
		
		# str[i]
		movq %rdi, %r8 # rdi = &str
		movq %rcx, %r9 # r9 = i
		imulq $1, %r9 # i * sizeof(char)
		addq %r8, %r9 # r9 = &str[i] = &str + (i * sizeof(char))
		movb (%r9), %r10b # r10b = str[i]
		
		#str[i] % v
		
		movb %r10b, %al #dividendo = str[i]
		movb %dl, %r11b #divisor = v
		cbtw
		idivb %r11b
		# resto -> %ah
		
		if:
			cmpb $0, %ah
			je end_if
			
			#str[i]
			movq %rdi, %r8 # rdi = &str
			movq %rcx, %r9 # r9 = i
			imulq $1, %r9 # i * sizeof(char)
			addq %r8, %r9 # r9 = &str[i] = &str + (i * sizeof(char))
			movb (%r9), %r10b # c = r10b = str[i]
			
			movzbl %r10b, %r10d #(unsigned int)c
			
			movq %rdi, -8(%rbp) #salva str
			movq %rsi, -16(%rbp) #salva size
			movq %rdx, -24(%rbp) #salva v
			movq %rcx, -32(%rbp) #salva i
			
			movl %r10d, %edi # c -> 1o param
			call toupper
			
			movq -8(%rbp), %rdi #salva str
			movq -16(%rbp), %rsi #salva size
			movq -24(%rbp), %rdx #salva v
			movq -32(%rbp), %rcx #salva i
			
			#str[i]
			movq %rdi, %r8 # rdi = &str
			movq %rcx, %r9 # r9 = i
			imulq $1, %r9 # i * sizeof(char)
			addq %r8, %r9 # r9 = &str[i] = &str + (i * sizeof(char))
			
			movb %al ,(%r9)
			
			
			
		end_if:
		
		incq %rcx # i++ 
		jmp while
	end_while: 
	
	leave 
	ret

.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	
	movq $str, %rdi #1o param (char *str)
	movq $21, %rsi #2o param (size_t size)
	movb $2, %dl #3o param (char v)
	
	call process
	
	movq $fmt, %rdi #1o param 
	movq $str, %rsi #2o param
	movl $0, %eax # 0 pontos flutuantes

	call printf
	
	movl $0, %eax #return 0
	
	leave 
	ret
