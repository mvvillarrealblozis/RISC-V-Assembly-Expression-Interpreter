.global eval_s
.global isdigit_s
.global number_s
.global factor_s
.global term_s
.global expression_s

# a0 - char *expr_str
# a1 - int *pos
# a2 - int value
# a3 - char token
# t0 - ascii var '+' 43 
# t1 - ascii var '-' 45 
# returns value 


expression_s:
	addi sp, sp, -48
	sd ra, (sp)
	sd a0, 8(sp)
	sd a1, 16(sp)
	sd t0, 24(sp)
	sd t1, 32(sp)

	call number_s
	mv a2, a0 
	
	sd a2, 40(sp)

	ld a2, 40(sp)
	ld t1, 32(sp)
	ld t0, 24(sp)
	ld a1, 16(sp)
	ld a0, 8(sp)
	
	j expression_s_while

	mv a0, a2	


	ld ra, (sp)
	addi sp, sp, 48
	ret
	 
expression_s_while:
	li t0, 43 									# t0 = '+'
	li t1, 45 									# t1 = '-'

	add a0, a0, 1
	lb a3, (a0) 								# load byte at expr_str into a3 (token)

	beq a3, t0, expression_s_add				# expr_str[*pos] == '+'
	beq a3, t1, expression_s_sub 				# expr_str[*pos] == '-'

	ret

expression_s_add:
	addi a0, a0, 1								# increase expr_str ptr

	call number_s
	
	ld a2, 40(sp)
	
	add a2, a2, a0 								# add the value returned by term_s 

	j expression_s_while


expression_s_sub:
	addi a0, a0, 1								# increase expr_str ptr

	call number_s 
	
	ld a2, 40(sp)

	sub a2, a2, a0								# subtract the value returned by term_s
	
	j expression_s_while	
	


############################################

# a0 - char *expr_str
# a1 - int *pos
# a2 - int value
# a3 - char token
# t0 - ascii var '*' 42
# t1 - ascii var '/' 47
# returns value

term_s:
	addi sp, sp, -24
	sd ra, (sp)
	sd t0, 8(sp)
	sd t1, 16(sp)

	call factor_s

	ld t0, 8(sp)
	ld t1, 16(sp)

	ld ra, (sp)
	addi sp, sp, 24
	ret 

term_s_while:
	li t0, 42									# t0 = '*'
	li t1, 47									# t1 = '/'

	lb a3, (a0)
	
	beq a3, t0, term_s_multiply					# expr_str[*pos] == '*'
	beq a3, t1, term_s_divide					# expr_str[*pos] == '/'

	ret 
	
term_s_multiply:
	addi a0, a0, 1								# increase expr_str ptr 

	call factor_s

	mul a2, a2, a0								# multiply the value by the result of factor_s

	j term_s_while

term_s_divide:
	addi a0, a0, 1								# increase expr_str ptr 

	call factor_s

	div a2, a2, a0 								# divide the value by the result of factor_s 

	j term_s_while


############################################

# a0 - char *expr_str
# a1 - int *pos
# a2 - int value
# a3 - char token
# t0 - ascii var '(' 40 
# t1 - ascii var ')' 41 
# returns value

factor_s:
	addi sp, sp, -24 
	sd ra, (sp)
	sd t0, 8(sp)
	sd t1, 16(sp)
	
	li t0, 40
	li t1, 41
	
	lb a3, (a0)
	
	beq a3, t0, factor_s_expression

	call number_s

	ld t0, 8(sp)
	ld t1, 16(sp)

	ld ra, (sp)
	addi sp, sp, 24
	ret 

factor_s_expression:
	addi a0, a0, 1 								# increment expr_srt ptr 

	call expression_s 

	addi a0, a0, 1 								# skip closing paren 



############################################

# a0 - char c 
# t0 - ascii var '0' 48
# t1 - ascii var '9' 57
# return 0 if true 1 if false 

isdigit_s:
	li t0, 48
	li t1, 57
	
	blt a0, t0, not_isdigit_s
	bgt a0, t1, not_isdigit_s
	
	li a0, 1									# return 1 if char is a digit 
	ret

not_isdigit_s:
	li a0, 0									# return 0 if char is not a digit 
	ret 


############################################

# a0 - char *expr_str
# a1 - int *pos
# a2 - int value
# a3 - char token
# a4 - temp 
# t0 - ascii var '0' 48
# t1 - 10 

number_s:
	addi sp, sp, -32
	sd ra, (sp)
	
	li a2, 0									# int value = 0 
	li t0, 48 
	li t1, 10 

number_s_while:
	lb a3, (a0)									# load current char 

	beqz a3, number_s_while_done

	sd a0, 8(sp)
	sd t0, 16(sp)
	sd t1, 24(sp)

	mv a0, a3
	
	call isdigit_s

	beqz a0, error

	ld a0, 8(sp)
	ld t0, 16(sp)
	ld t1, 24(sp)

	sub a3, a3, t0 								# token = token - '0'
	mul a2, a2, t1 								# value = value * 10 
	add a2, a2, a3 								# value * 10 + (token - '0')

	addi a1, a1, 1								# *pos += 1 
	addi a0, a0, 1
	
	j number_s_while

error:
	li a0, 0

number_s_while_done:
	mv a0, a2 
	ld ra, (sp)
	addi sp, sp, 32
	ret



############################################

# a0 - char *expr_str 	
# a1 - int pos 

eval_s:
	addi sp, sp, -16
	sd ra, (sp)
	
	li a1, 0
	
	call expression_s

	ld ra, (sp)
	addi sp, sp, 16
    ret
