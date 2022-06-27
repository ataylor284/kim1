;;; print HELLO on 7-segment display

SAD    := $1740
PADD   := $1741
SBD    := $1742

.org $0200

main_loop:
        ldx #0

next_digit:
        lda #$7F
        sta PADD
        lda digit_sbd,x
        sta SBD
        lda digit_value,x
        sta SAD

        jsr delay

        inx
        cpx #6
        bne next_digit
        jmp main_loop

delay:  ldy #$7F
dloop:  dey   
        bne dloop
        rts

digit_sbd:
        .byte $09, $0B, $0D, $0F, $11, $13
digit_value:
        .byte $F6, $F9, $B8, $B8, $BF, $00
