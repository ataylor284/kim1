;;; print 123456 on 7-segment display

.include "kim1.inc"

.org $0200

        lda #$12
        sta POINTH
        lda #$34
        sta POINTL
        lda #$56
        sta INH
loop:   jsr SCANDS
        jmp loop
