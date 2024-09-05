.data

.globl a
.align 4
a: .int 1

.globl b
.align 8
b: .quad 6

.text

.globl ex02

ex02:

    pushq %rbp

    movq  %rsp, %rbp


    # Seu código aqui...
    
    //if(a != 0)
    if01:
        cmpl $0, a 
        je end_if01

        //if(b < 5)
        if01_01:
            cmpq $5, b
            jge else_if01_01

            //(a * b)
            movslq a, %rax // rax = (long) a
            imulq b, %rax // rax = a * b
            
            // a << 1
            movslq a, %rcx // rcx = (long) a
            shlq $1, %rcx // rcx = a << 1

            addq %rax, %rcx // (a << 1) + (a * b)
            movq %rcx, b // b = (a << 1) + (a * b)
        
            jmp end_if01_01
        else_if01_01:
            movq b, %rax  // rax = b
            xorq $0x1FL, %rax // rax = b ^ 0x1FL
            movl %eax, a // a = b ^ 0x1FL

        
        end_if01_01:


    end_if01:

    leave

    ret