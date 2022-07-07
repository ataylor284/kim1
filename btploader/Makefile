.PHONY: clean all

include ../kim_defs.mk

PTP_LOAD_ADDR=0xD000

all: loader.ptp
	cp *.ptp *.bin $(ROOT)bin

clean:
	rm -f *.o *.ptp *.bin *.lst *.lbl *.map *~
