# simple rules for building kim binaries and paper tape files using the cc65 tools and srec_cat from srecord

AS=ca65
LD=ld65
ASFLAGS=
LDFLAGS=--target none 
PTP_LOAD_ADDR=0x0200

%.o %.lst: %.s
	$(AS) $(ASFLAGS) --listing $*.lst $<

%.bin %.map %.lbl: %.o
	$(LD) $(LDFLAGS) --start-addr $(PTP_LOAD_ADDR) $< -o $@ -m $*.map -Ln $*.lbl

%.ptp: %.bin
	srec_cat $< -binary -offset $(PTP_LOAD_ADDR) -o $@ -MOS_Technologies

# keep intermediate files around
.SECONDARY:
