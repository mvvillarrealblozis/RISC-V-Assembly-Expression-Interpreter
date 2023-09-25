.global unpack_bytes_s

# a0 - int val
# a1 - uint32_t bytes[]

# t0 - uint32_t b
# t1 - int i
# t2 - temp 

unpack_bytes_s:
	li t1, 0 				# i = 0 
	li t2, 4				# temp = 4 
loop:
	bge t1, t2, done

	andi t0, a0, 0xFF
	sb t0, (a1)

	srli a0, a0, 8 
	addi a1, a1, 4

	addi t1, t1, 1
	j loop

	
done:
	ret
