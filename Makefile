PROGS = rstr rstr_rec eval get_bitseq get_bitseq_signed pack_bytes unpack_bytes

RSTR_OBJS = rstr.o rstr_c.o rstr_s.o
RSTR_REC_OBJS = rstr_rec.o rstr_rec_c.o rstr_rec_s.o
EVAL_OBJS = eval.o eval_c.o eval_s.o
GET_BITSEQ_OBJS = get_bitseq.o get_bitseq_s.o get_bitseq_c.o
GET_BITSEQ_SIGNED_OBJS = get_bitseq_signed.o\
						 get_bitseq_signed_c.o get_bitseq_c.o\
                         get_bitseq_signed_s.o get_bitseq_s.o
PACK_OBJS = pack_bytes.o pack_bytes_c.o pack_bytes_s.o
UNPACK_OBJS = unpack_bytes.o unpack_bytes_c.o unpack_bytes_s.o

OBJS = $(RSTR_OBJS) $(RSTR_REC_OBJS) $(EVAL_OBJS) \
	   $(GET_BITSEQ_OBJS) $(GET_BITSEQ_SIGNED_OBJS) \
       $(PACK_OBJS) $(UNPACK_OBJS)

%.o: %.c
	gcc -c -g -o $@ $<

%.o: %.s
	as -g -o $@ $<

all: $(PROGS)

rstr: $(RSTR_OBJS)
	gcc -g -o $@ $^

rstr_rec: $(RSTR_REC_OBJS)
	gcc -g -o $@ $^

eval: $(EVAL_OBJS)
	gcc -g -o $@ $^

get_bitseq: $(GET_BITSEQ_OBJS)
	gcc -g -o $@ $^

get_bitseq_signed: $(GET_BITSEQ_SIGNED_OBJS)
	gcc -g -o $@ $^

pack_bytes: $(PACK_OBJS)
	gcc -g -o $@ $^

unpack_bytes: $(UNPACK_OBJS)
	gcc -g -o $@ $^

clean:
	rm -rf $(PROGS) $(OBJS)
