.data

.globl s
.align 4
s: .int 0

.globl nums
.align 4
nums: .int 65, -105, 111, 34

.text



.globl sum

sum:

	pushq %rbp

	movq  %rsp, %rbp



	# Seu código aqui...

	movl $0, %eax # eax = int i = 0
	while:
		cmpl $4, %eax
		jge end_while
		
		#nums[i] 
		movq $nums, %rcx # rcx = &nums
		movslq %eax, %rdx # (long) i
		imulq $4, %rdx # i*sizeof(int)
		addq %rdx, %rcx # rcx = &nums[i] = &nums + (i*sizeof(int))
		movl (%rcx), %edi # edi = nums[i]
		
		# s = s + nums[i]
		addl s, %edi
		movl %edi, s
		
		incl %eax #i++
		jmp while
	end_while:

	leave

	ret
