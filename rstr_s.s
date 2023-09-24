.global rstr_s
.global strlen

# Reverse a string iteratively
# a0 - char *dst
# a1 - char *src
# t0 - int i
# t1 - int j
# t2 - int strlen(src)
# t3 - temp num
# t4 - temp byte
# t5/t6 temp registers


rstr_s:
	addi sp, sp, -24		# allocate space on stack
	sd ra, (sp)				# store return address
	sd a0, 8(sp)			# store a0 (*dst) val in stack
	sd a1, 16(sp)			# store a1 (*src) val in stack
	
	mv a0, a1				# mv a1 (src) to a0
	
	call strlen 			# call strlen with a0(src str)
	
	mv t2, a0 				# store strlen(src) in t2
	
	ld a0, 8(sp)			# load a0 (*dst) val from stack
	ld a1, 16(sp)			# load a1 (*src) val from stack 
	
	li t0, 0				# i = 0
	add t1, t2, -1			# j = src_Len - 1
	
loop:
	bge t0, t2, done 		# if t0 >= t2 go to done label
	add t3, a1, t1 			# calculate address (a1 + j) and store in t3 
	lb t4, (t3)				# load byte from source at the jth index

	add t5, a0, t0			# calculate address (a0 + i) and store in t5
	sb t4, (t5)				# store the byte from src to dst at ith postion 
	
	addi t0, t0, 1			# i++
	addi t1, t1, -1			# j-- 

	j loop

done: 	
	add t6, a0, t2			# calculate address (ao + strlen(src)) and store in t6 
	sb zero, (t6)			# insert null terminator at the end of the string 
	
	ld ra, (sp)
	addi sp, sp, 24
    ret
