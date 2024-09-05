.data

.globl last
.align 8
last: .quad 0

.globl values
.align 8
values: .quad 50,-10,60,-20,70

.text

.globl swap

swap:

    pushq %rbp

    movq  %rsp, %rbp


    # Seu código aqui...
    //for (i = 0; i < j; i++, j--)
    movl $0, %r8d // r8 = i = 0
    movl $4, %r9d // r9 = j = 4
    for01:
    cmpl %r9d, %r8d
    jge end_for01
        
        
        //long tmp = values[i];
        movq $values, %rax // rax = &values
        movslq %r8d ,%rcx // rcx = (long) i
        imulq $8, %rcx // rcx = i * sizeof(long)
        addq %rax, %rcx // rcx = &values[i] = values + i * sizeof(long)
        movq (%rcx), %rdx // edx = temp = values[i]

        //values[j]
        movq $values, %rax // rax = &values
        movslq %r9d, %r10 // r10 = (long) j 
        imulq $8, %r10 //r10 = j * sizeof(long)
        addq %rax, %r10 // r10 = &values[j] = values + j * sizeof(long)
        movq (%r10), %r11 // r11 = temp2 = values[j]

        //values[i] = values[j]
        movq %r11, (%rcx) 
        //values[j] = temp
        movq %rdx, (%r10)

        incl %r8d //i++
        decl %r9d //j--
        jmp for01

    end_for01:
    
    movq $values, %rax // rax = values
    movabs $4, %rcx // rcx = indice = 4
    imulq $8, %rcx // rcx = 4 * sizeof(long)
    addq %rax, %rcx // rcx = &values[4] = values + sizeof(int)
    movq (%rcx), %rdx // rdx = temporaria = values[4]

    movq %rdx, last

    leave

    ret