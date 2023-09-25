.global pack_bytes_s

# a0 - uint32_t b3
# a1 - uint32_t b2
# a2 - uint32_t b1
# a3 - uint32_t b0

# t0 - int32_t val 

pack_bytes_s:
	li t0, 0		# int32_t val = 0

	mv t0, a0

	slli t0, t0, 8
	or t0, t0, a1

	slli t0, t0, 8
	or t0, t0, a2

	slli t0, t0, 8
	or t0, t0, a3

	mv a0, t0
		
    ret

