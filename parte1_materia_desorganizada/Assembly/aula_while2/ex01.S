.data 

.align 2
.globl vet
vet: .word 50, 10, 67, 42

.align 2
.globl max
max: .word 0

.text 

.globl ex01
ex01:
    pushq %rbp
    movq %rsp, %rbp

    //for (i = 0; i < 4; i++)
    movb $0, %cl //cl = i = 0
    start_for: 
        cmpb $4, %cl 
        jge end_for

        //r8w = vet[i]
        movq $vet, %rax // rax = &vet
        movsbq %cl, %rdx // rdx = (long) i
        imulq $2, %rdx 
        addq %rax, %rdx

        movw (%rdx), %r8w

        start_if:
            cmpw max, %r8w
            jle end_if

            movw %r8w, max

        end_if:

        incb %cl // i++
        jmp start_for
    end_for:

    leave
    ret