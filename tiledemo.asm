.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

   jmp start

.include "x16.inc"

RETURN_CHAR = $0D

load_prompt:
.byte "loading graphics...",RETURN_CHAR

start:
   lda #<load_prompt
   sta ZP_PTR_1
   lda #>load_prompt
   sta ZP_PTR_1+1
   ldy #0
@load_print_loop:
   lda (ZP_PTR_1),y
   jsr CHROUT
   iny
   cmp #RETURN_CHAR
   bne @load_print_loop
   ; TODO the actual loading
   rts
