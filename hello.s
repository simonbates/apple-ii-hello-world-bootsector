; Copyright (c) 2018 Simon Bates
;
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:
;
; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.


; TODO When I turn the motor off, can I assume that x is set
;      appropriately for the controller slot number?
; TODO Set the character code high bit (ora #$80) at assembly-time,
;      rather than run-time
; TODO Power-on booting works, but PR#6 fails (stuck with drive motor on)

; The Disk II controller card will load us into $0800
* = $0800

MOTOROFF = $C088
BASIC = $e000
COUT = $fded

        .byt $01        ; Load 1 sector at boot

; Turn the drive motor off
        lda MOTOROFF,x  ; Can I assume that x is set appropriately for slot number?

; Print "HELLO WORLD"
        ldx #$00
loop    lda message,x
        beq done
        ora #$80        ; Use regular letters rather than flashing
        jsr COUT
        inx
        bne loop
done
        jmp BASIC       ; Start BASIC
message
        .asc "HELLO WORLD"
        .byt $00
