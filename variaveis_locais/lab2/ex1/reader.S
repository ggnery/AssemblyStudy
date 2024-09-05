.section .rodata

	fmt1: .string "id1 = %d, id2 = %d, id3 = %d\n"
	fmt2: .string "Person ID: %ld\n"
	fmt3: .string "Car ID: %ld\n"
	fmt4: .string "tipo = %d, ID = %ld, nome = '%s', cor = '%s'\n"
	
.text
.globl reader
reader: 
	pushq %rbp
	movq %rsp, %rbp
	subq $144, %rsp
	
	
	
	#PARAMETROS
	#long verbose -> %rdi
	
	# readPerson(&p, &id1)
	movq %rdi, -8(%rbp)
	
	leaq -64(%rbp), %rdi # 1o param (&p)
	leaq -12(%rbp), %rsi # 2o param (&id1)
	
	call readPerson
	
	#readCar(&c[0], &id2)
	movq %rdi, -8(%rbp)
	
	leaq -144(%rbp), %rdi #1o param (&c[0])
	leaq -16(%rbp), %rsi  #2o param (&id2)
	
	call readCar
	
	#readCar(&c[1], &id3)
	movq %rdi, -8(%rbp)
	
	leaq -104(%rbp), %rdi #1o param (&c[1])
	leaq -20(%rbp), %rsi  #2o param (&id2)
	
	call readCar
	
	if01:
		cmpq $0, %rdi
		je end_if01
		
		# printf("id1 = %d, id2 = %d, id3 = %d\n", id1, id2, id3)
		movq %rdi, -8(%rbp)
		
		movq $fmt1, %rdi # 1o param
		movl -12(%rbp), %esi #2o param (id1)
		movl -16(%rbp), %edx #3o param (id2)
    		movl -20(%rbp), %ecx #4o param (id3)
    		movq $0, %eax
    		
    		call printf
    		
    		movq -8(%rbp), %rdi
    		
    		# printf("Person ID: %ld\n", p.ID)
    		movq %rdi, -8(%rbp)
    		
    		movq $fmt2, %rdi #1o param
    		
    		# p.ID
    		movq %rdi, -8(%rbp)
    		
    		leaq -64(%rbp), %r8 # &p
    		movq 8(%r8), %rsi # 2o param
    		movq $0, %eax
    		
    		call printf
    		
    		movq -8(%rbp), %rdi	
    			
    		# printf("Car ID: %ld\n", c[0].ID)
    		movq %rdi, -8(%rbp)
    		
    		movq $fmt3, %rdi #1o param
    		
    		# c[0].ID
    		leaq -144(%rbp), %r8
    		movq 8(%r8), %rsi # 2o param
    		movq $0, %eax
    		
    		call printf 
    	
    		movq -8(%rbp), %rdi
    		
    		# printf("Car ID: %ld\n", c[1].ID)
    		
    		movq %rdi, -8(%rbp)
    		
    		movq $fmt3, %rdi #1o param
    		
    		# c[1].ID
    		leaq -104(%rbp), %r8
    		movq 8(%r8), %rsi # 2o param 	
    		movq $0, %eax
    		
    		call printf
	
		movq -8(%rbp), %rdi
		
	end_if01:
	
	# showPerson(&p)
	movq %rdi, -8(%rbp)
	
	leaq -64(%rbp), %rdi # 1o param
	call showPerson
	
	movq -8(%rbp), %rdi
	
	#showCar(&c[0])
	movq %rdi, -8(%rbp)
	
	leaq  -104(%rbp), %rdi #1o param
	call showCar
	
	movq -8(%rbp), %rdi
	
	#showCar(&c[0])
	movq %rdi, -8(%rbp)
	
	leaq  -144(%rbp), %rdi #1o param
	call showCar
	
	movq -8(%rbp), %rdi
	
	leave
	ret
	
.globl showPerson
showPerson:
	pushq %rbp
	movq %rsi, %rbp
	
	#PARAMETROS
	# struct Person *person -> %rdi
	
	movq $fmt4, %rdi # 1o param
	movl (%rdi), %esi # 2o param (person->type)
	movq 8(%rdi), %rdx #3o param (person->ID)
	leaq 16(%rbp), %rcx #4o param
	movl 32(%rbp), %r8d # 5o param
	movq $0, %eax
	
	call printf
	
	leave
	ret
	
