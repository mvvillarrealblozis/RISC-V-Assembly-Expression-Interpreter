.global rstr_s
.global printf
.global strlen

# Reverse a string iteratively
# a0 - char *dst
# a1 - char *str
# t0 - int i
# t1 - int j
# t2 - int strlen(src)

rstr_s:
	addi sp, sp, -16
	sd ra, (sp)

	call strlen 
	mv t2, a0 				# store strlen(src) in t2
	
	li t0, 0				# i = 0
	add t1, t2, -1			# j = src_Len - 1	

loop:
	blt t0, t2, done

	lb t3, (a1)
	sb t3, (a0)

	addi a0, a0, 1
	addi a1, a1, -1

done: 
	sb zero, (a0)
	
	ld ra, (sp)
	addi sp, sp, 16
    ret
