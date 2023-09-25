.global get_bitseq_signed_s
.global get_bitseq_s

# a0 - int32_t num 
# a1 - int start
# a2 - int end 

# t0 - uint32_t val
# t1 - val_signed
# t2 - len
# t3 - shift_amt
# t4 - temp for 32

get_bitseq_signed_s:
	addi sp, sp, -16
	sd ra, (sp)
	
	sub t2, a2, a1			# len = (end - start) 
	addi t2, t2, 1 			# len += 1 
	li t4, 32
	sub t3, t4, t2			# shift_amt = 32 - len

	sd t3, 8(sp)

	call get_bitseq_s

	ld t3, 8(sp)
	
	sll t0, a0, t3 			# val = val << shift_amt
	sraw t1, t0, t3			# ((int) val) >> shift_amt 

	mv a0, t1
	
	ld ra, (sp)
	addi sp, sp, 16 
    ret
