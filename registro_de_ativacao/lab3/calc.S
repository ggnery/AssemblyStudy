.section .rodata

fmt: .string "%d: sum = %ld\n"
fmt2: .string "retorno = %ld\n"

.data

.globl v
.align 2
v: .word 1, 2, 3, 4, 5

.globl max
.align 2
max: .word 0 

.text

.globl main
main:
    pushq %rbp
    movq %rsp, %rbp

    movq $v, %rdi # 1o param (short *vet)
    movl $5, %esi # 2o param (int size)
    movl $2, %edx # 3o param (int factor)
    movq $max, %rcx # 4o param (short *max)
    movb $1, %r8b # 5o param (char option)

    call calc

    movq $fmt2, %rdi #1o param 
    movq %rax, %rsi #2o param (long r) 
    movq $0, %rax #numero pontos flutuantes
    
    call printf

    movl $0, %eax # return 0
    leave
    ret

.globl calc
calc:
    pushq %rbp
    movq %rsp, %rbp
    subq $64, %rsp 
    
    movq %r12, -8(%rbp) 
    movq %r13, -16(%rbp)
    movq %r14, -24(%rbp)

    # r12w = short value 
    movl $0, %r13d # int i = 0
    movq $0, %r14  # long sum = 0; 

    while:
        cmpl %esi ,%r13d 
        jge end_while

        #value = vet[i]
        movq %rdi, %r9 # rcx = &vet
        movslq %r13d, %r10 # (long) i
        imulq $2, %r10 # i * sizeof(short)
        addq %r10, %r9 # r10 = &vet + (i * sizeof(short))
        movw (%r9), %r12w # value = vet[i]

        if:
            cmpw %r12w, (%rcx)
            jge end_if

            movw %r12w, (%rcx) # *max = value 

        end_if:

        #sum = (long)(*max * (short)factor)
        movw %dx, %r9w #(short) factor
        imulw (%rcx), %r9w # (*max * (short)factor)
        movswq %r9w, %r14 # r14 = sum = (long)(*max * (short)factor)

        #printf("%d: sum = %ld\n", i++, sum)
        
        #Salva parametros
        movq %rdi, -32(%rbp) 
        movq %rsi, -40(%rbp)
        movq %rdx, -48(%rbp)
        movq %rcx, -56(%rbp)
        movq %r8, -64(%rbp)

        movq $fmt, %rdi # 1o param  
        movl %r13d, %esi # 2o param 
        incl %r13d # i++
        movq %r14, %rdx # 3o param
        movl $0, %eax # n pontos flutuantes
        
        call printf

        #Recupera parametros
        movq -32(%rbp), %rdi 
        movq -40(%rbp), %rsi 
        movq -48(%rbp), %rdx
        movq -56(%rbp), %rcx 
        movq -64(%rbp), %r8 
        

        jmp while
    end_while:

    if02:
        cmpb $1, %r8b
        jne end_if02

        movq %r14 ,%rax #return sum
        
        movq -8(%rbp) ,%r12 
        movq -16(%rbp) ,%r13 
        movq -24(%rbp), %r14 
        
        leave
        ret

    end_if02:
    movq $0, %rax #return 0

    movq -8(%rbp) ,%r12 
    movq -16(%rbp) ,%r13 
    movq -24(%rbp), %r14 

    leave 
    ret


