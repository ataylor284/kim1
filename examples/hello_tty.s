;;; print hello world! on the tty

OUTCH := $1EA0

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
