    .section .rodata
        fmt: .string "%d\n"

    .text

    .globl show

show:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp
    # i = ecx
    
    #for(i = 0; i<size; i++)
    movl $0, %ecx
    
    for01:
        cmpl %esi, %ecx
        jge endfor01

        #printf("%d\n", v[i])
        movq %rcx, -8(%rbp)
        movq %rdi, -16(%rbp)
        movq %rsi, -24(%rbp)


        #v[i]
        movq %rdi, %r8
        movslq %ecx, %r9
        imulq $4, %r9
        addq %r8, %r9

        movl (%r9), %esi

        movq $fmt, %rdi

        movl $0, %eax
        call printf
    
        movq -8(%rbp), %rcx
        movq -16(%rbp), %rdi
        movq -24(%rbp), %rsi
        
        incl %ecx
        jmp for01
    endfor01:

    leave
    ret
