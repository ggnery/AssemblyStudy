.section .rodata
	fmt1: .string "Objeto local [1] igual!\n"
	fmt2: .string "Objeto global igual!\n"
.data

	.globl gObj
	.align 4
	gObj: .zero 24		

.text

.globl find
find:
	pushq %rbp
	movq %rsp, %rsp
	subq $80, %rsp
	
	
	#PARAMETROS
	# guid_t *id -> rdi
	
	
	movl $0, -12(%rbp) #int found = 0
	# lObj esta em -60(%rbp)
	# pins esta em -70(%rbp)
	
	# chamando init_obj(&gObj, 0)
	
	movq %rdi, -8(%rbp) #salvo parametro de find
	
	movq $gObj, %rdi # 1o param
	movl $0, %esi # 2o param
	
	call init_obj
		
	movq -8(%rbp), %rdi #salvo parametro de find
	
	# chamando init_obj(&lObj[0], 1)
	
	movq %rdi, -8(%rbp) #salvo parametro de find
	
	leaq -60(%rbp), %rdi # 1o param
	movl $1, %esi # 2o param
	
	call init_obj
		
	movq -8(%rbp), %rdi #salvo parametro de find

	# chamando init_obj(&lObj, 2)
	
	movq %rdi, -8(%rbp) #salvo parametro de find
	
	leaq -36(%rbp), %rdi # 1o param
	movl $2, %esi # 2o param
	
	call init_obj
		
	movq -8(%rbp), %rdi #salvo parametro de find

	# chamando init_pins(pins)
	
	movq %rdi, -8(%rbp) #salvo parametro de find
	
	leaq -70(%rbp), %rsi #1o param
	
	call init_pins
	
	movq -8(%rbp), %rdi #salvo parametro de find

	# calling compare_guid(&lObj[1].id, id)
	movq %rdi, -8(%rbp) #salvo parametro de find
	
	movq %rdi, %rsi #2o param (id)
	
	leaq -36(%rbp), %r8 # r8 = &lObj[1]
	leaq 4(%r8), %rdi #1o param
	
	call compare_guid
	
	movq -8(%rbp), %rdi #salvo parametro de find
	
	if01:
		cmpl $0, %eax
		je end_if01
		
		# calling printf
		movq %rdi, -8(%rbp) #salvo parametro de find
		
		movq $fmt1, %rdi #1o param
		movl $0, %eax # 0 pontos flutuantes
		
		call printf	
		
		movq -8(%rbp), %rdi #salvo parametro de find
	end_if01:
		
	# calling compare_guid(id, &gObj.id)
	movq %rdi, -8(%rbp) #salvo parametro de find
	
	# rdi ja esta no 1o param
	
	movq $gObj, %r8 # r8 = &gObj
	leaq 4(%r8), %rsi #2o param
	
	call compare_guid
	
	movq -8(%rbp), %rdi #salvo parametro de find
	
	if02:
		cmpl $0, %eax
		je end_if02
		
		# calling printf
		movq %rdi, -8(%rbp) #salvo parametro de find
		
		movq $fmt2, %rdi #1o param
		movl $0, %eax # 0 pontos flutuantes
		
		call printf	
		
		movq -8(%rbp), %rdi #salvo parametro de find
	
	end_if02:
	
	movl $0, %r8d # int i = 0
	for01:
		cmpl $2, %r8d
		jge end_for01
		
		movl $0, %r9d
		for02:
			cmpl $5, %r9d
			jge end_for02
			
			#pins[j]
			leaq -70(%rbp), %r10 # &pins
			movslq %r9d, %r11 # (long) j
			imulq $2, %r11 # j * sizeof(short)
			addq %r10, %r11 # &pins[j]
			movw (%r11), %cx # pins[j]
			
			#lObj[i]
			leaq -60(%rbp), %r10 # &lObj
			movslq %r8d, %r11 # (long) i
			imulq $24, %r11 # j * sizeof(rfid_object_s)
			addq %r10, %r11 # &lObj[i]
			
			movw 20(%r11), %dx # lObj[i].pin
			
			if03:
				cmpw %dx, %cx
				jne end_if03
				
				movl $1, -12(%rbp)
				jmp saida
			
			end_if03:
		
			jmp for02
		end_for02:
		
		incl %r8d
		jmp for01
	end_for01:
	
	saida:
	movl -12(%rbp), %eax

	leave 
	ret	
