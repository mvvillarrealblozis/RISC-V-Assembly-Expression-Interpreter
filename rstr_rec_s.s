\.global rstr_rec_s
.global strlen


# Reverse a string recursively

# a0 - char *dst
# a1 - int dst_idx
# a2 - char *src 
# a3 - int src_idx

rstr_rec_c:
	addi sp, sp, -32
	sd ra, (sp)

	sd a0, (sp)
	sd a1, 8(sp)
	sd a2, 16(sp)
	sd a3, 24(sp)

	mv a0, a1
	
	call strlen

	ld a0, (sp)
	ld a1, 8(sp)
	ld a2, 16(sp)
	ld a3, 24(sp)

	call rstr_rec_s
	
	
rstr_rec_s:
	beq a3, zero, base_case
	

base_case:


done:

	addi sp, sp, 32
	ret 
