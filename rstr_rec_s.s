.global rstr_rec_s
.global strlen

# Reverse a string recursively

# a0 - char *dst
# a1 - int dst_idx
# a2 - char *src 
# a3 - int src_idx

rstr_rec_s:
	addi sp, sp, -40
	sd ra, (sp)

	sd a0, 8(sp)
	sd a1, 16(sp)
	sd a2, 24(sp)
	sd a3, 32(sp)

	mv a0, a2								# move source into a0 
	
	call strlen

	ld a0, 8(sp)
	ld a1, 16(sp)
	ld a2, 24(sp)
	ld a3, 32(sp)

	call rstr_rec_func_s

	ld ra, (sp)
	
rstr_rec_func_s:

	lb t0, (a2)
	
	beq t0, zero, base_case

	sb t0, (a0)	
	
	addi a1, a1, 1
	addi a2, a2, -1

	call rstr_rec_s

	
	j done 
	

base_case:
	sb zero, (a0)

done:
	ld ra, (sp)
	addi sp, sp, 40
	ret 
