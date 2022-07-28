; c64 "print ascii to screen" subroutine
CHROUT = $ffd2

; $fb-$fe are zeropage addresses unused by the os
ZP_PTR = $fb

    .macro print, str_ptr
    ; Store previous register values
    pha
    tya
    pha
    ; Prep arguments: Store the str_ptr address in the zeropage &
    ; initialize y = 0
    lda #<\str_ptr
    sta ZP_PTR
    lda #>\str_ptr
    sta ZP_PTR+1
    ldy #0
print_loop\@:
    lda (ZP_PTR),y
    beq print_quit\@
    jsr CHROUT
    iny
    jmp print_loop\@
print_quit\@:
    ; Restore previous register values
    pla
    tay
    pla
    .endmacro 

; Free assembly memory area is $c000-$cfff
; $c000 is 49152 in decimal, so SYS 49152 to run
    .org $c000

main:
    print TEST_STR
    rts

TEST_STR: .string "HELLO, WORLD!"
