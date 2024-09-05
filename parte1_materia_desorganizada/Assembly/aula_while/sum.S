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
    
    movl $0, %ecx // i 
    while01:
        // while(i < 4)
        cmpl $4, %ecx   
        jge end_while01

        movq $nums, %r8 // r8 = &nums
        movslq %ecx, %r9 // r9 = (long) i 
        imulq $4, %r9 // r9 = i * sizeof(int)
        addq %r8, %r9 // r9 = &nums[i]
        movl (%r9), %edx

        addl %edx, s

        //i++
        incl %ecx 

        jmp while01
    end_while01:

    leave

    ret