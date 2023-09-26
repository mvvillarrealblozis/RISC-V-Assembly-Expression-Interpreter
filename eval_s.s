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
    addi sp, sp, -64                          # Adjust stack pointer for local storage
    sd ra, (sp)                               # Save return address

    sd a0, 8(sp)                              # Store a0 on stack
    sd a1, 16(sp)                             # Store a1 on stack

    call term_s                               # Call term_s function
    mv t0, a0                                 # t0 (value) = term_s(expr_str, pos)

    ld a0, 8(sp)                              # Restore a0 from stack
    ld a1, 16(sp)                             # Restore a1 from stack

expression_while:
    lw t2, (a1)                               # t2 (pos_val) = *a1 (pos)
    add t3, a0, t2                            # t3 = a0 (*expr_str) + t2 (pos_val)
    lb t1, (t3)                               # t1 (token) = *t3
    li t4, '+'                                # Load ASCII value of '+'
    beq t1, t4, expression_while_cont         # If token is '+', jump to expression_while_cont
    li t5, '-'                                # Load ASCII value of '-'
    bne t1, t5, expression_while_done         # If token is not '-', jump to expression_while_done

expression_while_cont:
    addi t2, t2, 1                            # Increment position value
    sw t2, (a1)                               # Update position in memory

    bne t1, t4, expression_while_else         # If token is not '+', jump to expression_while_else

    sd a0, 8(sp)                              # Preserve registers before function call
    sd a1, 16(sp)
    sd t0, 24(sp)
    sd t1, 32(sp)
    sd t2, 40(sp)
    sd t4, 48(sp)
    sd t5, 56(sp)

    call term_s                               # Call term_s function

    ld t0, 24(sp)                             # Restore t0 (value) from stack
    add t0, t0, a0                            # t0 (value) = t0 (value) + a0

    ld a0, 8(sp)                              # Restore the rest of the saved registers
    ld a1, 16(sp)
    ld t1, 32(sp)
    ld t2, 40(sp)
    ld t4, 48(sp)
    ld t5, 56(sp)

    j expression_while                        # Jump back to start of while loop

expression_while_else:
    bne t1, t5, expression_while_done         # If token is not '-', jump to expression_while_done

    sd a0, 8(sp)                              # Preserve registers before function call
    sd a1, 16(sp)
    sd t0, 24(sp)
    sd t1, 32(sp)
    sd t2, 40(sp)
    sd t4, 48(sp)
    sd t5, 56(sp)

    call term_s                               # Call term_s function

    ld t0, 24(sp)                             # Restore t0 (value) from stack
    sub t0, t0, a0                            # t0 (value) = t0 (value) - a0

    ld a0, 8(sp)                              # Restore the rest of the saved registers
    ld a1, 16(sp)
    ld t1, 32(sp)
    ld t2, 40(sp)
    ld t4, 48(sp)
    ld t5, 56(sp)

    j expression_while                        # Jump back to start of while loop

expression_while_done:
    mv a0, t0                                 # a0 = t0 (value)
    ld ra, (sp)                               # Restore return address
    addi sp, sp, 64                           # Adjust stack pointer back
    ret                                       # Return from function

############################################

# a0 - char *expr_str
# a1 - int *pos
# t0 - int value
# t1 - char token
# t2 - int pos_val

term_s:
    addi sp, sp, -64                          # Adjust stack pointer for local storage
    sd ra, (sp)                               # Save return address

    sd a0, 8(sp)                              # Store a0 on stack
    sd a1, 16(sp)                             # Store a1 on stack

    call factor_s                             # Call factor_s function
    mv t0, a0                                 # t0 (value) = result of factor_s(expr_str, pos)

    ld a0, 8(sp)                              # Restore a0 from stack
    ld a1, 16(sp)                             # Restore a1 from stack

term_while:
    lw t2, (a1)                               # t2 (pos_val) = *a1 (pos)
    add t3, a0, t2                            # t3 = a0 (*expr_str) + t2 (pos_val)
    lb t1, (t3)                               # t1 (token) = *t3
    li t4, '*'                                # Load ASCII value of '*'
    beq t1, t4, term_while_cont               # If token is '*', jump to term_while_cont
    li t5, '/'                                # Load ASCII value of '/'
    bne t1, t5, term_while_done               # If token is not '/', jump to term_while_done

term_while_cont:
    addi t2, t2, 1                            # Increment position value
    sw t2, (a1)                               # Update position in memory

    bne t1, t4, term_while_else               # If token is not '*', jump to term_while_else

    sd a0, 8(sp)                              # Preserve registers before function call
    sd a1, 16(sp)
    sd t0, 24(sp)
    sd t1, 32(sp)
    sd t2, 40(sp)
    sd t4, 48(sp)
    sd t5, 56(sp)

    call factor_s                             # Call factor_s function

    ld t0, 24(sp)                             # Restore t0 (value) from stack
    mul t0, t0, a0                            # t0 (value) = t0 (value) * result of factor_s

    ld a0, 8(sp)                              # Restore the rest of the saved registers
    ld a1, 16(sp)
    ld t1, 32(sp)
    ld t2, 40(sp)
    ld t4, 48(sp)
    ld t5, 56(sp)

    j term_while                              # Jump back to start of while loop

term_while_else:
    bne t1, t5, term_while_done               # If token is not '/', jump to term_while_done

    sd a0, 8(sp)                              # Preserve registers before function call
    sd a1, 16(sp)
    sd t0, 24(sp)
    sd t1, 32(sp)
    sd t2, 40(sp)
    sd t4, 48(sp)
    sd t5, 56(sp)

    call factor_s                             # Call factor_s function

    ld t0, 24(sp)                             # Restore t0 (value) from stack
    div t0, t0, a0                            # t0 (value) = t0 (value) / result of factor_s

    ld a0, 8(sp)                              # Restore the rest of the saved registers
    ld a1, 16(sp)
    ld t1, 32(sp)
    ld t2, 40(sp)
    ld t4, 48(sp)
    ld t5, 56(sp)

    j term_while                              # Jump back to start of while loop

term_while_done:
    mv a0, t0                                 # a0 = t0 (value)
    ld ra, (sp)                               # Restore return address
    addi sp, sp, 64                           # Adjust stack pointer back
    ret                                       # Return from function


############################################

# a0 - char *expr_str
# a1 - int *pos
# a2 - int value
# a3 - char token
# t0 - ascii var '(' 40 
# t1 - ascii var ')' 41 
# t6 - temp val reg
# returns value

factor_s:
    addi sp, sp, -64                          # Adjust stack pointer for local storage
    sd ra, (sp)                               # Save return address
    sd a0, 8(sp)                              # Store a0 on stack
    sd a1, 16(sp)                             # Store a1 on stack
    sd a2, 24(sp)                             # Store a2 on stack
    sd a3, 32(sp)                             # Store a3 on stack
    sd t0, 40(sp)                             # Store t0 on stack
    sd t1, 48(sp)                             # Store t1 on stack

    li t0, '('                                # Load ASCII value of '('
    li t1, ')'                                # Load ASCII value of ')'

    lw t2, (a1)                               # Load position value
    add t3, a0, t2                            # Calculate address of current character
    lb a3, (t3)                               # Load current character

    beq a3, t0, factor_s_if                   # If current character is '(', jump to factor_s_if

    call number_s                             # Call number_s function

    mv t6, a0                                 # Store result in t6

    j factor_done                             # Jump to end of function

factor_s_if:
    sd a0, 8(sp)                              # Preserve registers before function call
    sd a1, 16(sp)
    sd a2, 24(sp)
    sd a3, 32(sp)
    sd t0, 40(sp)
    sd t1, 48(sp)

    addi t2, t2, 1                            # Increment position value
    sw t2, (a1)                               # Update position in memory

    call expression_s                         # Call expression_s function

    mv t6, a0                                 # Store result in t6

    ld a0, 8(sp)                              # Restore a0 from stack
    ld a1, 16(sp)                             # Restore a1 from stack
    ld a3, 32(sp)                             # Restore a3 from stack

    lw t2, (a1)                               # Load position value
    add t3, a0, t2                            # Calculate address of current character
    lb a3, (t3)                               # Load current character

    bne a3, t1, factor_error                  # If current character is not ')', jump to factor_error

    addi t2, t2, 1                            # Increment position value
    sw t2, (a1)                               # Update position in memory

factor_done:
    mv a0, t6                                 # Return value in a0
    ld ra, (sp)                               # Restore return address
    addi sp, sp, 64                           # Adjust stack pointer back
    ret                                       # Return from function

factor_error:
    li a0, 0                                  # Return 0 on error
    ret                                       # Return from function


############################################

# a0 - char c 
# t0 - ascii var '0' 48
# t1 - ascii var '9' 57
# return 0 if true 1 if false 

isdigit_s:
    li t0, '0'                                # Load ASCII value of '0'
    li t1, '9'                                # Load ASCII value of '9'

    blt a0, t0, not_isdigit_s                 # If char is less than '0', jump to not_isdigit_s
    bgt a0, t1, not_isdigit_s                 # If char is greater than '9', jump to not_isdigit_s

    li a0, 1                                  # Return 1 if char is a digit
    ret

not_isdigit_s:
    li a0, 0                                  # Return 0 if char is not a digit
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
    addi sp, sp, -48                          # Adjust stack pointer for local storage
    sd ra, (sp)                               # Save return address

    li a2, 0                                  # Initialize value to 0
    li t0, 48                                 # Load ASCII value of '0'
    li t1, 10                                 # Load constant 10

number_s_while:
    lw t2, (a1)                               # Load position value
    add t3, a0, t2                            # Calculate address of current character
    lb a3, (t3)                               # Load current character

    beqz a3, number_s_while_done              # If char is null, exit loop

    sd a0, 8(sp)                              # Store registers on stack
    sd a1, 16(sp)
    sd t0, 24(sp)
    sd t1, 32(sp)
    sd t2, 40(sp)

    mv a0, a3                                 # Move current character to a0

    call isdigit_s                            # Check if char is a digit

    beqz a0, error                            # If not a digit, jump to error

    ld a0, 8(sp)                              # Restore registers from stack
    ld a1, 16(sp)
    ld t0, 24(sp)
    ld t1, 32(sp)
    ld t2, 40(sp)

    sub a3, a3, t0                            # Convert char to integer
    mul a2, a2, t1                            # Multiply current value by 10
    add a2, a2, a3                            # Add converted integer to value

    addi t2,t2, 1                             # Increment position value
    sw t2, (a1)                               # Update position in memory

    j number_s_while                          # Repeat loop

error:
    li a0, 0                                  # Return 0 on error

number_s_while_done:
    mv a0, a2                                 # Return value in a0
    ld ra, (sp)                               # Restore return address
    addi sp, sp, 48                           # Adjust stack pointer back
    ret

############################################

# a0 - char *expr_str 	
# a1 - int pos 

eval_s:
    addi sp, sp, -16                          # Adjust stack pointer for local storage
    sd ra, (sp)                               # Save return address

    addi a1, sp, 8                            # Point a1 to position on stack
    sw zero, (a1)                             # Initialize position to 0

    call expression_s                         # Evaluate expression

    ld ra, (sp)                               # Restore return address
    addi sp, sp, 16                           # Adjust stack pointer back
    ret                                       # Return from function
