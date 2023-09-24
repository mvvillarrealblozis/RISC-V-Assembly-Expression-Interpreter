.global get_bitseq_signed_s
.global get_bitseq_s

# a0 - int32_t num 
# a1 - int start
# a2 - int end 

# t0 - uint32_t val
# t1 - val_signed
# t2 - len
# t3 - shift_amt
# t4 - temp 

get_bitseq_signed_s:
	addi sp, sp, -64
	sd ra, (sp)
	
	
	sub t2, a2, a1			# len = (end - start) 
	add t2, t2, 1 			# len += 1 
	li t4, 32
	
	add t3, 		# shift_amt = 32 - len

	sd a0, 8(sp)
	sd a1, 16(sp)
	sd a2, 24(sp)
	sd t0, 32(sp)
	sd t1, 40(sp)
	sd t2, 48(sp)
	sd t3, 56(sp)
	
	call get_bitseq_s

	mv a5, a0
	
	ld a0, 8(sp)
	ld a1, 16(sp)
	ld a2, 24(sp)
	ld t0, 32(sp)
	ld t1, 40(sp)
	ld t2, 48(sp)
	ld t3, 56(sp)

	sll a5, a5, t3 

	sra a0, a5, a4 
	
    ret
