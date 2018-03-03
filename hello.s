;
; A simple Apple II boot sector that prints "HELLO WORLD" on screen
; and then starts BASIC
;
; License http://unlicense.org
;

; Boot sector layout:
;
; - Byte 0 -- The number of sectors from track 0 to be read by the disk
;   controller on boot
; - Byte 1 onwards -- The code to be executed at boot
;
; The disk controller will read the number of sectors specified in
; the first byte of the boot sector into memory starting at location
; $0800. Once this data has been read, it will JMP to the boot sector
; code at $0801.
;
; Upon entry to the boot sector, the X-Register will hold the boot
; slot number * 16 ($s0). This value is also in zero page location
; $2B.

; TODO Set the character code high bit (ora #$80) at assembly-time,
;      rather than run-time

; The disk controller will load us into $0800
* = $0800

MOTOROFF = $c088
BASIC = $e000
COUT = $fded
SETVID = $fe93

        .byt $01        ; Load 1 sector at boot

; Turn the drive motor off
        lda MOTOROFF,x  ; The X-Register contains boot slot number * 16

; Select screen output
        jsr SETVID

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
