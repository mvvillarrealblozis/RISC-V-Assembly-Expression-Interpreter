.global rstr_s
.global printf
.global strlen

# Reverse a string iteratively
# a0 - char *dst
# a1 - char *src
# t0 - int i
# t1 - int j
# t2 - int strlen(src)
# t3 - temp char
# t4 - temp 

rstr_s:
	addi sp, sp, -16
	sd ra, (sp)

	lw t4, (a0)
	
	sd t4, 8(sp)
	mv a0, a1
	call strlen 
	
	mv t2, a0 				# store strlen(src) in t2
	ld t4, 8(sp)
	
	li t0, 0				# i = 0
	add t1, t2, -1			# j = src_Len - 1	

	mv a0, t4
	add a1, a1, t1

loop:
	bge t0, t2, done

	lb t3, (a1)
	sb t3, (a0)

	addi a0, a0, 1
	addi a1, a1, -1

	addi t0, t0, 1

	j loop

done: 
	sb zero, (a0)
	
	ld ra, (sp)
	addi sp, sp, 16
    ret
