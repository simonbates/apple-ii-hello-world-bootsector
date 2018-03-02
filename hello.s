; TODO When I turn the motor off, can I assume that x is set
;      appropriately for the controller slot number?
; TODO Set the character code high bit (ora #$80) at assembly-time,
;      rather than run-time

; The Disk II controller card will load us into $0800
* = $0800

MOTOROFF = $c088
BASIC = $e000
COUT = $fded
SETVID = $fe93

        .byt $01        ; Load 1 sector at boot

; Turn the drive motor off
        lda MOTOROFF,x  ; Can I assume that x is set appropriately for slot number?

; Select screen output
        jsr SETVID      ; Is this adequate? Do I need to do more initialization?

; Print "HELLO WORLD"
        ldx #$00
loop    lda message,x
        beq done
        ora #$80        ; Use regular letters rather than flashing
        jsr COUT
        inx
        bne loop

; Start BASIC
done
        jmp BASIC

message
        .asc "HELLO WORLD"
        .byt $00
