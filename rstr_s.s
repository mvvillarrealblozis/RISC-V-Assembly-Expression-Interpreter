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
	addi sp, sp, -24		# allocate space on stack
	sd ra, (sp)				# store return address

	lw t4, (a0)				# load val of a0(*dst) into t4 for future use
	lw t5, (a1)				# load val of a1(*src) into t5 for future use
	
	sd t4, 8(sp)			# store the value of t4(*dst) onto the stack 
	sd t5, 16(sp)			# store the value of t5(*src) onto the stack 
	
	mv a0, a1				# mv a1 (src) to a0
	
	call strlen 			# call strlen with a0(src str)
	
	mv t2, a0 				# store strlen(src) in t2
	
	ld t4, 8(sp)			# restore value kept in t4(*dst)
	ld t5, 16(sp)			# restore value kept in t5(*src)
		

	mv a0, t4				# move t4(*dst) back into a0 
	mv a1, t5				# move t5(*src) back into a1

	li t0, 0				# i = 0
	add t1, t2, -1			# j = src_Len - 1
	
loop:
	bge t0, t2, done 		# if t0 >= t2 go to done label

	lb t3, (a1)				# t3 = src[i]
	sb t3, (a0)				# dst[i] = src[i] or t3 

	addi t0, t0, 16			# i++
	addi t1, t1, -16		# j-- 

	j loop

done: 
	#sb zero, (a0)
	
	ld ra, (sp)
	addi sp, sp, 24
    ret
