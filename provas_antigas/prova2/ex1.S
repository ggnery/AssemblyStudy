.section .rodata
	
	fmt: .string "%d, %ld\n"
	
.data

	.globl values
	.align 4
	velues: .int 10, 20, 10, 40, 20, 50, 30, 10

.text
.globl process
process:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	
	#Parametros
	#int stamp -> %edi
	#long limit -> %rsi
	#char base -> %dl
	
	movl $7, %ecx # int i = 7
	for:
		cmpl $0, %ecx
		jl end_for
		
		#values[i]
		movq $values, %r8 # &values
		movslq %ecx, %r9 # (long) i
		imulq $4, %r9 # i * sizeof(int)
		addq %r8, %r9 # &v[i]
		movl (%r9), %r10d # v[i]
		
		if:
			cmpl %r10d, %edi
			jle else
			
			#chamando aux()
			
			movq %rdi, -8(%rbp) #salvo stamp 
			movq %rsi, -16(%rbp) #salvo limit
			movq %rdx, -24(%rbp) #salvo base
			movq %rcx, -32(%rbp) # salvo i
			
			#(short) i
			movw %cx, %di# 1o param
			
			#(long) i
			movslq %ecx, %rsi
			
			# values + i
			imulq $4, %rsi # i *sizeof(int)
			addq $values , %rsi #2o param
			
			call aux
			
			movq -8(%rbp), %rdi  #recupero stamp 
			movq -16(%rbp), %rsi #recupero limit
			movq -24(%rbp), %rdx #recupero base
			movq -32(%rbp), %rcx #recupero i
			
			# retorno esta em rax
			
			#limit * 2
			imulq $2, %rsi
			
			# limit = (2 * limit) + aux((short) i, (values + i))
			addq %rax, %rsi
			
			jmp end_else
		else:
			movq %rdi, -8(%rbp) #salvo stamp 
			movq %rsi, -16(%rbp) #salvo limit
			movq %rdx, -24(%rbp) #salvo base
			movq %rcx, -32(%rbp) # salvo i
			
			movq %rsi, %rdx #3o param
			movl %edi, %esi #2o param
			movq $fmt, %rdi #1o param
			movl $0, %ecx # 0 pontos flutuantes
			call printf
			
			movq -8(%rbp), %rdi  #recupero stamp 
			movq -16(%rbp), %rsi #recupero limit
			movq -24(%rbp), %rdx #recupero base
			movq -32(%rbp), %rcx #recupero i
			
		end_else:
			
		decl %ecx # i--
		jmp for
	end_for:
	
	#return limit
	movq %rsi, %rax
	
	
	leave
	ret
	

