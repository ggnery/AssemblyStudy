.data

.align 1
.globl letters
letters: .string "abcdefghij"

.align 4
.globl even
even: .int 0

.align 4
.globl odd
odd: .int 0

.text
.globl ex02

ex02:
    pushq %rbp
    movq %rsp, %rbp

    movl $0, %ecx //unsigned int count = ecx = 0;
    
    
    start_while:
        //letters[count]
        movq $letters, %rax // rax = &letters
        movl %ecx, %edx // (unsigned long) count
        imulq $1, %rdx // edx = count * sizeof(char) 
        addq %rax, %rdx // &letters + (count * sizeof(char))
        movb (%rdx), %r8b // r8b = letters[count]
        
        //while(letters[count])
        cmpb $0, %r8b
        jne end_while

        start_if:
            //letters[count++]
            addl %ecx // count++            
            movq $letters, %rax // rax = &letters
            movl %ecx, %edx // (unsigned long) count
            imulq $1, %rdx // rdx = count * sizeof(char) 
            addq %rax, %rdx // rdx = [] &letters + (count * sizeof(char))
            movb (%rdx), %r8b // r9b = letters[count++]
            
            andb $1, %r8b 
            
            //if(letters[count++] & 1)
            cmpb $0, %r8b
            jne start_else

                movl odd, %edx
                incl %edx
                movl %edx, odd

                jmp end_if
        start_else:

        end_else:

        end_if:

        jmp start_while
    end_while:

    leave
    ret