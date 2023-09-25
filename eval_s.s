.global eval_s
.global isdigit_s
.global number_s
.global factor_s
.global term_s
.global expression_s

# a0 - char *expr_str
# a1 - int *pos

# t0 - int value
# t1 - char token
# t2 - int pos_val

expression_s:
    addi sp, sp, -64
    sd ra, (sp)

    sd a0, 8(sp)        # Store a0 on stack
    sd a1, 16(sp)       # Store a1 on stack
                        # These are caller-saved
                        # and we need them after
                        # the call to term_s
    call term_s
    mv t0, a0           # t0 (value) = term_s(expr_str, pos)

    ld a0, 8(sp)        # Restore a0 from stack
    ld a1, 16(sp)       # Restore a1 from stack

expression_while:
    lw t2, (a1)         # t2 (pos_val) = *a1 (pos)
    add t3, a0, t2      # t3 = a0 (*expr_str) + t2 (pos_val)
    lb t1, (t3)         # t1 (token) = *t3
    li t4, '+'
    beq t1, t4, expression_while_cont
    li t5, '-'
    bne t1, t5, expression_while_done

expression_while_cont:
    addi t2, t2, 1      # t2 (pos_val) = t2 (pos_val) + 1
    sw t2, (a1)         # *pos = t2 (pos_val)

    bne t1, t4, expression_while_else

    sd a0, 8(sp)        # We need to preserve all caller-saved
    sd a1, 16(sp)       # registers we are currently using.
    sd t0, 24(sp)
    sd t1, 32(sp)
    sd t2, 40(sp)
    sd t4, 48(sp)
    sd t5, 56(sp)

    call term_s

    ld t0, 24(sp)       # Restore t0 (value) from stack
    add t0, t0, a0      # t0 (value) = t0 (value) + a0

    ld a0, 8(sp)        # Restore the rest of the caller-saved
    ld a1, 16(sp)       # Registers.
    ld t1, 32(sp)
    ld t2, 40(sp)
    ld t4, 48(sp)
    ld t5, 56(sp)

    j expression_while

expression_while_else:
    bne t1, t5, expression_while_done

    sd a0, 8(sp)
    sd a1, 16(sp)       # Preserve all caller-saved regs
    sd t0, 24(sp)       # that we are using.
    sd t1, 32(sp)
    sd t2, 40(sp)
    sd t4, 48(sp)
    sd t5, 56(sp)

    call term_s

    ld t0, 24(sp)       # Restore t0 (value) from stack
    sub t0, t0, a0      # t0 (value) = t0 (value) - a0

    ld a0, 8(sp)        # Restore all caller-saved regs
    ld a1, 16(sp)       # that we are using.
    ld t1, 32(sp)
    ld t2, 40(sp)
    ld t4, 48(sp)
    ld t5, 56(sp)

    j expression_while

expression_while_done:
    mv a0, t0           # a0 = t0 (value)
    ld ra, (sp)
    addi sp, sp, 64
    ret

############################################

# a0 - char *expr_str
# a1 - int *pos

# t0 - int value
# t1 - char token
# t2 - int pos_val

term_s:
    addi sp, sp, -64
    sd ra, (sp)

    sd a0, 8(sp)        # Store a0 on stack
    sd a1, 16(sp)       # Store a1 on stack
                        # These are caller-saved
                        # and we need them after
                        # the call to term_s
    call factor_s
    mv t0, a0           # t0 (value) = term_s(expr_str, pos)

    ld a0, 8(sp)        # Restore a0 from stack
    ld a1, 16(sp)       # Restore a1 from stack

term_while:
    lw t2, (a1)         # t2 (pos_val) = *a1 (pos)
    add t3, a0, t2      # t3 = a0 (*expr_str) + t2 (pos_val)
    lb t1, (t3)         # t1 (token) = *t3
    li t4, '*'
    beq t1, t4, term_while_cont
    li t5, '/'
    bne t1, t5, term_while_done

term_while_cont:
    addi t2, t2, 1      # t2 (pos_val) = t2 (pos_val) + 1
    sw t2, (a1)         # *pos = t2 (pos_val)

    bne t1, t4, term_while_else

    sd a0, 8(sp)        # We need to preserve all caller-saved
    sd a1, 16(sp)       # registers we are currently using.
    sd t0, 24(sp)
    sd t1, 32(sp)
    sd t2, 40(sp)
    sd t4, 48(sp)
    sd t5, 56(sp)

    call factor_s

    ld t0, 24(sp)       # Restore t0 (value) from stack
    mul t0, t0, a0      # t0 (value) = t0 (value) * a0

    ld a0, 8(sp)        # Restore the rest of the caller-saved
    ld a1, 16(sp)       # Registers.
    ld t1, 32(sp)
    ld t2, 40(sp)
    ld t4, 48(sp)
    ld t5, 56(sp)

    j expression_while

term_while_else:
    bne t1, t5, term_while_done

    sd a0, 8(sp)
    sd a1, 16(sp)       # Preserve all caller-saved regs
    sd t0, 24(sp)       # that we are using.
    sd t1, 32(sp)
    sd t2, 40(sp)
    sd t4, 48(sp)
    sd t5, 56(sp)

    call factor_s

    ld t0, 24(sp)       # Restore t0 (value) from stack
    div t0, t0, a0      # t0 (value) = t0 (value) / a0

    ld a0, 8(sp)        # Restore all caller-saved regs
    ld a1, 16(sp)       # that we are using.
    ld t1, 32(sp)
    ld t2, 40(sp)
    ld t4, 48(sp)
    ld t5, 56(sp)

    j term_while

term_while_done:
    mv a0, t0           # a0 = t0 (value)
    ld ra, (sp)
    addi sp, sp, 64
    ret


############################################

# a0 - char *expr_str
# a1 - int *pos
# a2 - int value
# a3 - char token
# t0 - ascii var '(' 40 
# t1 - ascii var ')' 41 
# returns value

factor_s:
	addi sp, sp, -56
	sd ra, (sp)
	sd a0, 8(sp)
	sd a1, 16(sp)
	sd a2, 24(sp)
	sd a3, 32(sp)
	sd t0, 40(sp)
	sd t1, 48(sp)
	
	li t0, '('
	li t1, ')'
	
	lw t2, (a1)
	add t3, a0, t2
	lb a3, (t3)
	
	beq a3, t0, factor_s_if

	call number_s

	mv a0, a2

	ld a0, 8(sp)
	ld a1, 16(sp)
	ld a2, 24(sp)
	ld a3, 32(sp)
	ld t0, 40(sp)
	ld t1, 48(sp)
	ld ra, (sp)
	addi sp, sp, 56
	ret 

factor_s_if:
	sd a0, 8(sp)
	sd a1, 16(sp)
	sd a2, 24(sp)
	sd a3, 32(sp)
	sd t0, 40(sp)
	sd t1, 48(sp)
	
	addi t2, t2, 1
	sw t2, (a1)

	call expression_s

	lw t2, (a1)
	add t3, a0, t2
	lb a3, (t3)

	bne a3, t1, factor_error

	addi t2, t2, 1
	sw t2, (a1)
	
	ld a0, 8(sp)
	ld a1, 16(sp)
	ld a2, 24(sp)
	ld a3, 32(sp)
	ld t0, 40(sp)
	ld t1, 48(sp)
	
factor_error:
	li a0, 0
	ret

############################################

# a0 - char c 
# t0 - ascii var '0' 48
# t1 - ascii var '9' 57
# return 0 if true 1 if false 

isdigit_s:
	li t0, '0'
	li t1, '9'
	
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
	addi sp, sp, -48
	sd ra, (sp)
	
	li a2, 0									# int value = 0 
	li t0, 48 
	li t1, 10 


number_s_while:
	lw t2, (a1)
	add t3, a0, t2
	lb a3, (t3)									# load current char 

	beqz a3, number_s_while_done

	sd a0, 8(sp)
	sd a1, 16(sp)
	sd t0, 24(sp)
	sd t1, 32(sp)
	sd t2, 40(sp)

	mv a0, a3
	
	call isdigit_s

	beqz a0, error

	ld a0, 8(sp)
	ld a1, 16(sp)
	ld t0, 24(sp)
	ld t1, 32(sp)
	ld t2, 40(sp)

	sub a3, a3, t0 								# token = token - '0'
	mul a2, a2, t1 								# value = value * 10 
	add a2, a2, a3 								# value * 10 + (token - '0')

	addi t2,t2, 1								# t2 (pos_val) = t2 (pos_val) + 1
	sw t2, (a1)
	
	j number_s_while

error:
	li a0, 0

number_s_while_done:
	mv a0, a2 
	ld ra, (sp)
	addi sp, sp, 48
	ret



############################################

# a0 - char *expr_str 	
# a1 - int pos 

eval_s:
	addi sp, sp, -16
	sd ra, (sp)
	
	addi a1, sp, 8								# a1 points to post on stack
	sw zero, (a1)
	
	call expression_s

	ld ra, (sp)
	addi sp, sp, 16
    ret
