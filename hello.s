        * = $0800       ; The Disk II ROM will load us into $0800

        .byt $01        ; Load 1 sector at boot

        ldx #$00
loop    lda message,x
        beq done
        ora #$80        ; Display regular letters rather than flashing
        jsr $fded       ; COUT
        inx
        bne loop
done
        jmp done        ; TODO wait for keypress and boot into BASIC
message
        .asc "HELLO WORLD"
        .byt $00
