.PHONY: clean all

include ../kim_defs.mk

all: hello_tty.ptp hello_kbd.ptp hello2_kbd.ptp timer.ptp
	cp *.ptp *.bin $(ROOT)bin

clean:
	rm -f *.o *.ptp *.bin *.lst *.lbl *.map *~
