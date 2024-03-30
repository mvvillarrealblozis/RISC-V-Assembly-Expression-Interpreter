.global rstr_rec_s
.global rstr_rec_func_s
.global strlen

# Reverse a string recursively

# a0 - char *dst
# a1 - char *src

# t0 - src_len 

rstr_rec_s:
	addi sp, sp, -32
	sd ra, (sp)
	sd a0, 8(sp)
	sd a1, 16(sp)
	
	mv a0, a1					# move source into a0 
	
	call strlen

	mv t0, a0					# t0 = src_len
	addi t0, t0, -1 			# src_len -= 1 

	ld a0, 8(sp)
	ld a1, 16(sp)

	mv a2, a1
	mv a1, zero
	mv a3, t0

	call rstr_rec_func_s

	ld ra, (sp)
	addi sp, sp, 32
	ret
		

rstr_rec_func_s:
	addi sp, sp, -16
	sd ra, (sp)

	add t2, a2, a3				# t2 = src + src_idx	
	lb t1, (t2)					# t1 = src[src_idx]

	beq t1, zero, base_case		# if src[src_idx] == '\0'

	add t3, a0, a1				# t3 = dst + dst_idx 
	sb t1, (t3)					# dst[dst_idx] = src[src_idx]

	addi a1, a1, 1				# dst_idx += 1
	addi a3, a3, -1				# src_idx -= 1

	call rstr_rec_func_s
	
	j done
	
base_case:
	add t3, a0, a1 
	sb zero, (t3)

done:
	ld ra, (sp)
	addi sp, sp, 16
	ret
