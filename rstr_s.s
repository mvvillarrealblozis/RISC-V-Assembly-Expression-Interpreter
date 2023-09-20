.global rstr_s
.global printf
.global strlen

# Reverse a string iteratively
# a0 - char *str
# t0 - int i
# t1 - int j
# t2 - int strlen(src)

rstr_s:
	addi sp, sp -16
	sd ra, (sp)

	la t2, 

	call strlen 
	
	li t0, 0	# i = 0



	ld ra, (sp)
	addi sp, sp, 16
    ret

loop:

done:
 
