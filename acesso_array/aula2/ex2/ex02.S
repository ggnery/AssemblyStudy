.section .rodata 

.data

.globl letters
.align 1
letters: .string "abcdefghij"

.globl even
.align 4
even: .int 0

.globl odd
.align 4
odd: .int 0

.text

.globl ex02
ex02:
	pushq %rbp
	movq %rsp, %rbp
	
	movl $0, %ecx # unsigned int count = 0 	
	
	while:
		#letters[count]
		movq $letters, %rax # rax = &letters
		movl %ecx, %edx # rdx = (long) count
		imulq $1, %rdx # count * sizeof(char)
		addq %rax, %rdx # rdx = &letters + (count * sizeof(char))
		movb (%rdx), %r8b # r8b = letters[count]
		
		cmpb $0, %r8b
		je end_while
		
		#letters[count++]
		movq $letters, %rax # rax = &letters
		movl %ecx, %edx # rdx = (long) count
		imulq $1, %rdx # count * sizeof(char)
		addq %rax, %rdx # rdx = &letters + (count * sizeof(char))
		movb (%rdx), %r9b # r9b = letters[count]
		
		incl %ecx # count++
		
		andb $1, %r9b # r9b = letters[count++] & 1
		
		
		if:
			cmpb $0, %r9b
			je else
			
			incl odd
			
			jmp end_else
		else:
			incl even
		
		end_else:
		
		jmp while
	end_while:
	
	leave 
	ret
	
 
