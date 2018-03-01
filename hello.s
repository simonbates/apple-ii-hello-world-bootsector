; The Disk II controller card will load us into $0800
* = $0800

COUT = $fded

        .byt $01        ; Load 1 sector at boot

        ldx #$00        ; Print "HELLO WORLD"
loop    lda message,x
        beq done
        ora #$80        ; Use regular letters rather than flashing
        jsr COUT
        inx
        bne loop
done
        jmp done        ; TODO Wait for keypress, continue boot into BASIC
message
        .asc "HELLO WORLD"
        .byt $00
