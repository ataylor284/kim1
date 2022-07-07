.PHONY: clean all msbasic

include ../kim_defs.mk

PTP_LOAD_ADDR=0x2000

all: msbasic-kb9.ptp
	cp *.ptp *.bin $(ROOT)bin

msbasic-kb9.bin:
	(cd msbasic && ./make.sh)
	cp msbasic/tmp/kb9.bin msbasic-kb9.bin

clean:
	rm -f *.ptp *.bin *.lst *.lbl *.map *~
