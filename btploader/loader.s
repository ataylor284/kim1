POINTL := $FA
POINTH := $FB
PRTBYT := $1E3B
GETCH  := $1E5A
OUTCH  := $1EA0
SCAND  := $1F19
INCPT  := $1F63
GETBYT := $1F9D
; -----------------------------------------------------------------------------
; older 6502s from the original KIM-1 era might have buggy ROR
; instruction; in that case use lsr and manually OR in carry to high
; bit - there is probably a more clever way to do this
.define ROR_WORKAROUND 0

.macro _ROR op
        .if ROR_WORKAROUND
                bcc :+
                pha
                lda op
                lsr
                ora #$80
                sta op
                pla
                jmp :++
:               lsr op
:
        .else
                ror op
        .endif
.endmacro        

; -----------------------------------------------------------------------------
; enable flashing the current address being loaded to on the lcd
.define LCD_PROGRESS_ENABLED 1

; -----------------------------------------------------------------------------
; misc uninitialized variables

.bss

output_byte1:    .res 1
output_byte2:    .res 1
output_byte3:    .res 1
verify:          .res 1
saved_x:         .res 1
failed:          .res 1
fail_loc:        .res 2

; -----------------------------------------------------------------------------
; entry point, start at entry+3 (verify_entry) to verify instead of load

.code
entry:
        ldx #0
        .byte $2c
verify_entry: 
        ldx #1
        stx verify
        cld
        ldx #0
        stx failed
loadbase64:
        jsr GETCH
        cmp #'@'
        bne loadbase64
found_header:
        jsr GETBYT              ; count
        tax
        jsr GETBYT              ; address hi
        sta POINTH
        jsr GETBYT              ; address lo
        sta POINTL
        txa
        beq zero_len_line_found
load_loop:
.if LCD_PROGRESS_ENABLED
        stx saved_x
        jsr SCAND               ; loads *POINT into INH then shows POINT:INH on LCD
        ldx saved_x
.endif
        jsr decode_4_to_3
        dex
        dex
        dex
        beq loadbase64
        bmi loadbase64
        bne load_loop

zero_len_line_found:
        jsr report_failures
        brk                     ; return to monitor

; -----------------------------------------------------------------------------
; turn 4 base64 chars into 3 data bytes, store at *POINT, and adjust
; POINT
;
; out1 = in1, then rotate in top 2 bits (bits 4 and 5 zero indexed) of in2 into bottom
; out2 = top nybble: bottom 4 bits of in2, bottom nybble: top 4 bits (bits 2,3,4,5 zero indexed) of in3
; out3 = in4, with bottom 2 bits in3 rotated into top
; 
; todo - get rid of temp output bytes?
.proc decode_4_to_3
        jsr GETCH               ; in1
        jsr base64_value_for_encoded_char
        sta output_byte1        

        jsr GETCH               ; in2
        jsr base64_value_for_encoded_char
        asl
        asl
        clc
        rol
        rol output_byte1
        clc
        rol 
        rol output_byte1
        sta output_byte2        

        lda #0
        sta output_byte3
        jsr GETCH               ; in3
        jsr base64_value_for_encoded_char
        lsr
        _ROR output_byte3
        lsr
        _ROR output_byte3
        ora output_byte2
        sta output_byte2

        jsr GETCH               ; in4
        jsr base64_value_for_encoded_char

        ora output_byte3
        sta output_byte3

        ldy #0

        lda verify
        bne do_verify

do_load:
        lda output_byte1
        sta (POINTL),y
        jsr INCPT
        lda output_byte2
        sta (POINTL),y
        jsr INCPT
        lda output_byte3
        sta (POINTL),y
        jsr INCPT
done:   rts

do_verify:
        lda output_byte1
        cmp (POINTL),y
        beq b1_ok
        jsr fail
b1_ok:
        jsr INCPT
        lda output_byte2
        cmp (POINTL),y
        beq b2_ok
        jsr fail
b2_ok:
        jsr INCPT
        lda output_byte3
        cmp (POINTL),y
        beq b3_ok
        jsr fail
b3_ok:
        jsr INCPT
        rts

fail:   lda failed
        bne fail_done
        inc failed
        lda POINTL
        sta fail_loc
        lda POINTH
        sta fail_loc+1
fail_done:
        rts
.endproc

; -----------------------------------------------------------------------------
; report failures that occured during verify with address of first bad byte
.data
fail_msg:
        .byte 10, 13, "verify failed at $", 0
.code
.proc report_failures
        lda failed
        beq report_failures_done
        ldx #0
fail_loop:      
        lda fail_msg,x
        beq print_fail_addr
        jsr OUTCH
        inx
        jmp fail_loop
print_fail_addr:
        lda fail_loc+1
        jsr PRTBYT
        lda fail_loc
        jsr PRTBYT
report_failures_done:
        rts
.endproc

; -----------------------------------------------------------------------------
; turn base 64 char in range A-Za-z0-9+/ and padding char '=' into
; 6-bit value it represents
.proc base64_value_for_encoded_char
        cmp #'/'
        beq is_slash
        bcc is_plus
not_plus_or_slash:
        cmp #'='
        beq is_equals
        bcc is_digit
not_equals_or_digit:
        cmp #'Z'+1
        bcs lowercase
        ;sec                    ; minus 1 since carry is clear
        sbc #'A'-1
        rts
lowercase:
        ;sec                    ; carry is set
        sbc #'a'-26
        rts
is_slash:
        lda #63
        rts
is_plus:
        lda #62
        rts
is_equals:
        lda #0
        rts
is_digit:
        ;clc                    ; carry is clear
        adc #4
        rts
.endproc
