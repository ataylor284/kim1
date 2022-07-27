;;; print hello world! on the tty

.include "kim1.inc"

.org $0200

        ldx #0
loop:   lda message,x
        beq done
        jsr OUTCH
        inx
        jmp loop
done:   brk

message:
        .byte 13, "hello world!", 0
