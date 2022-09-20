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

fn18_tiles:
.byte "1bpp8w.bin"
fn18_tiles_len = * - fn18_tiles
fn116_tiles:
.byte "1bpp16w.bin"
fn116_tiles_len = * - fn116_tiles
fn28_tiles:
.byte "2bpp8w.bin"
fn28_tiles_len = * - fn28_tiles
fn216_tiles:
.byte "2bpp16w.bin"
fn216_tiles_len = * - fn216_tiles
fn48_tiles:
.byte "4bpp8w.bin"
fn48_tiles_len = * - fn48_tiles
fn416_tiles:
.byte "4bpp16w.bin"
fn416_tiles_len = * - fn416_tiles
fn88_tiles:
.byte "8bpp8w.bin"
fn88_tiles_len = * - fn88_tiles
fn816_tiles:
.byte "8bpp16w.bin"
fn816_tiles_len = * - fn816_tiles
fn88_map:
.byte "map0808.bin"
fn88_map_len = * - fn88_map
fn816_map:
.byte "map0816.bin"
fn816_map_len = * - fn816_map
fn168_map:
.byte "map1608.bin"
fn168_map_len = * - fn168_map
fn1616_map:
.byte "map1616.bin"
fn1616_map_len = * - fn1616_map
fn1_pal:
.byte "1pal.bin"
fn1_pal_len = * - fn1_pal
fn2_pal:
.byte "2pal.bin"
fn2_pal_len = * - fn2_pal
fn4_pal:
.byte "4pal.bin"
fn4_pal_len = * - fn4_pal
fn8_pal:
.byte "8pal.bin"
fn8_pal_len = * - fn8_pal

hiram_file_table:
.byte 1  ; starting bank
.addr fn18_tiles
.byte fn18_tiles_len
.byte 3  ; starting bank
.addr fn116_tiles
.byte fn116_tiles_len
.byte 5  ; starting bank
.addr fn28_tiles
.byte fn28_tiles_len
.byte 8  ; starting bank
.addr fn216_tiles
.byte fn216_tiles_len
.byte 11  ; starting bank
.addr fn48_tiles
.byte fn48_tiles_len
.byte 17  ; starting bank
.addr fn416_tiles
.byte fn416_tiles_len
.byte 23  ; starting bank
.addr fn88_tiles
.byte fn88_tiles_len
.byte 35  ; starting bank
.addr fn816_tiles
.byte fn816_tiles_len
.byte 47  ; starting bank
.addr fn88_map
.byte fn88_map_len
.byte 49  ; starting bank
.addr fn816_map
.byte fn816_map_len
.byte 50  ; starting bank
.addr fn168_map
.byte fn168_map_len
.byte 51  ; starting bank
.addr fn1616_map
.byte fn1616_map_len

pal_1bpp:
.res 4
pal_2bpp:
.res 8
pal_4bpp:
.res 32
pal_8bpp:
.res 512



loram_file_table:
.addr pal_1bpp
.addr fn1_pal
.byte fn1_pal_len
.addr pal_2bpp
.addr fn2_pal
.byte fn2_pal_len
.addr pal_4bpp
.addr fn4_pal
.byte fn4_pal_len
.addr pal_8bpp
.addr fn8_pal
.byte fn8_pal_len


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
