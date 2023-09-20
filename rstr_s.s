.global rstr_s
.global printf

# Reverse a string iteratively
# a0 - char *str

rstr_s:
	addi sp, sp, -16
	sd ra, (sp)

	la a0, 
	call printf

	ld ra, (sp)
	addi sp, sp 16
	
    ret
    
