    .text
    .globl fat
fat:
    pushq %rbp
    movq %rsp, %rbp
    subq $16, %rsp

    if:
        cmpl $0, %edi
        jle end_if
        
        movq %rdi, -8(%rbp) //salvo %edi da pilha
        subl $1, %edi // %edi -1

        call fat // fat(%edi -1)
        
        movq -8(%rbp), %rdi //recupero %edi
        imull %edi, %eax

        leave
        ret

    end_if:
    movl $1, %eax //return 1
    leave
    ret
