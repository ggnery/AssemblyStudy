
.data

.globl size
.align 4
size: .int 5

.globl a
.align 2
a: .word 5, 1, 7, 2, 9

.globl b 
.align 4
b: .int 6, 3, 8, 4, 2

.globl nums 
.align 8
nums: .quad 0, 0, 0, 0, 0

.globl factor
.align 2
factor: .word 100

.text

.globl ex03
ex03:
	pushq %rbp
	movq %rsp, %rbp
	
	movl $0, %ecx # ecx = int i = 0
	movq $a, %rdx # short *ptr = a
	
	while:
		cmpl size, %ecx
		jge end_while
		
		# a[i]
		movq $a, %rax # &a
		movslq %ecx, %rsi # (long) i
		imulq $2, %rsi # i * sizeof(short)
		addq %rax, %rsi # &a[i] = &a + (i * sizeof(short)) 
		
		movw (%rsi), %r8w # a[i]
		
		if:
			cmpw $6, %r8w
			jle else
			
			# b[0] + factor
			
			movswl factor, %r8d # (int) factor
		
			movq $b, %rax  
			movl (%rax), %r9d # b[0]
			
			addl %r8d, %r9d # b[0] + factor
			
			# nums[i]
			movq $nums, %rax # &a
			movslq %ecx, %rsi # (long) i
			imulq $8, %rsi # i * sizeof(long)
			addq %rax, %rsi # &nums[i] = &nums + (i * sizeof(long)) 
			
			movslq %r9d, %r9 # (long) b[0] + factor
			
			# nums[i] = b[0] + factor
			movq %r9, (%rsi)
			
		
			jmp end_else
		else:
			# *ptr
			movswl (%rdx), %r9d # (int) *ptr
			
			#b[i]
			movq $b, %rax # &b
			movslq %ecx, %rsi # (long) i
			imulq $4, %rsi # i * sizeof(int)
			addq %rax, %rsi # &b[i] = &b + (i * sizeof(int)) 
			
			movl (%rsi), %r8d # (long) b[i]
			
			# *ptr * b[i]
			imull %r8d, %r9d 
			
			# nums[i]
			movq $nums, %rax # &a
			movslq %ecx, %rsi # (long) i
			imulq $8, %rsi # i * sizeof(long)
			addq %rax, %rsi # &nums[i] = &nums + (i * sizeof(long)) 
			
			# nums[i] = *ptr * b[i]
			movslq %r9d, %r9 # (long) (*ptr * b[i])
			movq %r9, (%rsi)
			
		
		end_else:
		
		incl %ecx
		addq $2, %rdx
		
		jmp while
	end_while:
	
	leave
	ret
	
