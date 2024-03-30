.global get_bitseq_s

# a0 - uint32_t num
# a1 - int start
# a2 - int end 

# t0 - uint32_t val
# t1 - int len 
# t2 - uint32_t mask


get_bitseq_s:
	sub t1, a2, a1			# len = (end - start)
	addi t1, t1, 1			# len = len + 1
	srlw t0, a0, a1

	li t3, 32
	bne t1, t3, else
	li t3, 0xFFFFFFFF
	j done
	
else:
	li t3, 1 
	sllw t3, t3, t1
	addi t3, t3, -1

done:
	and a0, t0, t3
	ret
