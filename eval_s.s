.global eval_s


# a0 - char *expr_str
# a1 - int *pos
# a2 - int value
# a3 - char token
# returns value 

expression_s:

	call term_s


	ret 
	
expression_s_while:



############################################

# a0 - char *expr_str
# a1 - int *pos
# a2 - int value
# a3 - char token
# returns value

term_s:
	

	call factor_s


term_s_while:




############################################

# a0 - char *expr_str
# a1 - int *pos
# a2 - int value
# a3 - char token
# returns value

factor_s:



	call expression_s



	call number_s




############################################

# a0 - char c 
# return 0 if true 1 if false 

isdigit_s:

	

############################################

number_s:

	call isdigit_s


############################################

# a0 - char *expr_str 	
# a1 - int pos 

eval_s:
	li a1, 0 

	call expression_s
	
    ret
