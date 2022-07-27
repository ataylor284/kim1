;;; use a timer 6530 timer to print something every second

.include "kim1.inc"

start:  jsr wait_250ms
        jsr wait_250ms
        jsr wait_250ms
        jsr wait_250ms
        lda #'*'
        jsr OUTCH
        lda #10
        jsr OUTCH
        lda #13
        jsr OUTCH
        jmp start

; start timer with $F4 and decrement every 1024 cycles - 249856 cycles in total, should take just under .25s
wait_250ms:
        lda #$F4
        sta CLKKT               
loop:   ; could do something useful here instead of burning cycles
        bit CLKRDI              ; loop until timer expired when register CLKRDI will be set
        bpl loop
        rts
