.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"

   jmp start

.include "x16.inc"

SWAP_CHAR   = $01
RETURN_CHAR = $0D
CLEAR_CHAR  = $93
LIGHT_GRAY  = $9B
TILE_SET = $00000
TILE_MAP = $17000

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

BANK_18_TILES  = 1
BANK_116_TILES = 3
BANK_28_TILES  = 5
BANK_216_TILES = 8
BANK_48_TILES  = 11
BANK_416_TILES = 17
BANK_88_TILES  = 23
BANK_816_TILES = 35
BANK_88_MAP    = 47
BANK_816_MAP   = 49
BANK_168_MAP   = 50
BANK_1616_MAP  = 51

hiram_file_table:
.addr fn18_tiles
.byte fn18_tiles_len
.byte BANK_18_TILES
.addr fn116_tiles
.byte fn116_tiles_len
.byte BANK_116_TILES
.addr fn28_tiles
.byte fn28_tiles_len
.byte BANK_28_TILES
.addr fn216_tiles
.byte fn216_tiles_len
.byte BANK_216_TILES
.addr fn48_tiles
.byte fn48_tiles_len
.byte BANK_48_TILES
.addr fn416_tiles
.byte fn416_tiles_len
.byte BANK_416_TILES
.addr fn88_tiles
.byte fn88_tiles_len
.byte BANK_88_TILES
.addr fn816_tiles
.byte fn816_tiles_len
.byte BANK_816_TILES
.addr fn88_map
.byte fn88_map_len
.byte BANK_88_MAP
.addr fn816_map
.byte fn816_map_len
.byte BANK_816_MAP
.addr fn168_map
.byte fn168_map_len
.byte BANK_168_MAP
.addr fn1616_map
.byte fn1616_map_len
.byte BANK_1616_MAP

pal_1bpp:
.res 4
pal_2bpp:
.res 8
pal_4bpp:
.res 32
pal_8bpp:
.res 512

loram_file_table:
.addr fn1_pal
.byte fn1_pal_len
.addr pal_1bpp
.addr fn2_pal
.byte fn2_pal_len
.addr pal_2bpp
.addr fn4_pal
.byte fn4_pal_len
.addr pal_4bpp
.addr fn8_pal
.byte fn8_pal_len
.addr pal_8bpp

title_8x8_8bpp:
.byte CLEAR_CHAR,RETURN_CHAR," 8x8 8bpp tiles",0

title_8x8_4bpp:
.byte CLEAR_CHAR,RETURN_CHAR," 8x8 4bpp tiles",0

title_8x8_2bpp:
.byte CLEAR_CHAR,RETURN_CHAR," 8x8 2bpp tiles",0

title_8x8_1bpp:
.byte CLEAR_CHAR,RETURN_CHAR," 8x8 1bpp tiles",0

title_8x16_8bpp:
.byte CLEAR_CHAR,RETURN_CHAR," 8x16 8bpp tiles",0

title_8x16_4bpp:
.byte CLEAR_CHAR,RETURN_CHAR," 8x16 4bpp tiles",0

title_8x16_2bpp:
.byte CLEAR_CHAR,RETURN_CHAR," 8x16 2bpp tiles",0

title_8x16_1bpp:
.byte CLEAR_CHAR,RETURN_CHAR," 8x16 1bpp tiles",0

title_16x8_8bpp:
.byte CLEAR_CHAR,RETURN_CHAR," 16x8 8bpp tiles",0

title_16x8_4bpp:
.byte CLEAR_CHAR,RETURN_CHAR," 16x8 4bpp tiles",0

title_16x8_2bpp:
.byte CLEAR_CHAR,RETURN_CHAR," 16x8 2bpp tiles",0

title_16x8_1bpp:
.byte CLEAR_CHAR,RETURN_CHAR," 16x8 1bpp tiles",0

title_16x16_8bpp:
.byte CLEAR_CHAR,RETURN_CHAR," 16x16 8bpp tiles",0

title_16x16_4bpp:
.byte CLEAR_CHAR,RETURN_CHAR," 16x16 4bpp tiles",0

title_16x16_2bpp:
.byte CLEAR_CHAR,RETURN_CHAR," 16x16 2bpp tiles",0

title_16x16_1bpp:
.byte CLEAR_CHAR,RETURN_CHAR," 16x16 1bpp tiles",0


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
   ; load palettes into low RAM
   lda #1
   ldx #8
   ldy #0
   jsr SETLFS
   ldx #4
   ldy #0
   lda #<loram_file_table
   sta ZP_PTR_2
   lda #>loram_file_table
   sta ZP_PTR_2+1
@loram_loop:
   phx
   lda (ZP_PTR_2),y   ; load filename address
   sta ZP_PTR_1
   iny
   lda (ZP_PTR_2),y
   sta ZP_PTR_1+1
   iny
   lda (ZP_PTR_2),y   ; load filename length
   pha
   jsr print_filename
   pla
   iny
   phy
   ldx ZP_PTR_1
   ldy ZP_PTR_1+1
   jsr SETNAM
   ply
   lda (ZP_PTR_2),y   ; load staging address
   tax
   iny
   lda (ZP_PTR_2),y
   iny
   phy
   tay
   lda #0
   jsr LOAD
   ply
   plx
   dex
   bne @loram_loop
   ; load tile sets and maps into high RAM
   ldx #12
   ldy #0
   lda #<hiram_file_table
   sta ZP_PTR_2
   lda #>hiram_file_table
   sta ZP_PTR_2+1
@hiram_loop:
   phx
   lda (ZP_PTR_2),y   ; load filename address
   iny
   sta ZP_PTR_1
   lda (ZP_PTR_2),y
   iny
   sta ZP_PTR_1+1
   lda (ZP_PTR_2),y   ; load filename length
   iny
   pha
   jsr print_filename
   pla
   ldx ZP_PTR_1
   phy
   ldy ZP_PTR_1+1
   jsr SETNAM
   ply
   lda (ZP_PTR_2),y  ; load RAM bank
   iny
   sta RAM_BANK
   lda #0
   ldx #<RAM_WIN
   phy
   ldy #>RAM_WIN
   jsr LOAD
   ply
   plx
   dex
   bne @hiram_loop
   lda VERA_L1_config
   ora #$08 ; turn on 256-color text mode
   sta VERA_L1_config
   lda #LIGHT_GRAY
   jsr CHROUT
   lda #SWAP_CHAR
   jsr CHROUT
   lda #LIGHT_GRAY
   jsr CHROUT
slide_8bpp_8x8:
   lda #<title_8x8_8bpp
   sta ZP_PTR_1
   lda #>title_8x8_8bpp
   sta ZP_PTR_1+1
   jsr print_title
   lda VERA_dc_video
   and #$EF
   sta VERA_dc_video ; disable layer 0
   lda #$63 ; 128x64 8bpp tiles
   sta VERA_L0_config
   lda #(TILE_MAP>>9)
   sta VERA_L0_mapbase
   stz VERA_L0_tilebase ; 8x8 tiles @ $00000
   stz VERA_ctrl
   VERA_SET_ADDR TILE_SET
.repeat 64
   stz VERA_data0    ; clear tile 0
.endrepeat
   lda #BANK_88_TILES
   sta RAM_BANK
   lda #<RAM_WIN
   sta ZP_PTR_1
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   ldy #0
@tile_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @tile_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @next_tile_bank
   sta ZP_PTR_1+1
   bra @tile_loop
@next_tile_bank:
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   lda RAM_BANK
   inc
   cmp #BANK_816_TILES
   beq @load_map
   sta RAM_BANK
   bra @tile_loop
@load_map:
   VERA_SET_ADDR TILE_MAP
   lda #BANK_88_MAP
   sta RAM_BANK
@map_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @map_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @next_map_bank
   sta ZP_PTR_1+1
   bra @map_loop
@next_map_bank:
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   lda RAM_BANK
   inc
   cmp #BANK_816_MAP
   beq @load_palette
   sta RAM_BANK
   bra @map_loop
@load_palette:
   lda #<pal_8bpp
   sta ZP_PTR_1
   lda #>pal_8bpp
   sta ZP_PTR_1+1
   VERA_SET_ADDR VRAM_palette
   ldy #0
   ldx #2
@pal_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @pal_loop
   inc ZP_PTR_1+1
   dex
   bne @pal_loop
@done:
   lda VERA_dc_video
   ora #$10
   sta VERA_dc_video ; enable layer 0
   jsr wait_key
slide_4bpp_8x8:
   lda #<title_8x8_4bpp
   sta ZP_PTR_1
   lda #>title_8x8_4bpp
   sta ZP_PTR_1+1
   jsr print_title
   lda VERA_dc_video
   and #$EF
   sta VERA_dc_video ; disable layer 0
   lda #$62 ; 128x64 4bpp tiles
   sta VERA_L0_config
   VERA_SET_ADDR TILE_SET
.repeat 32
   stz VERA_data0    ; clear tile 0
.endrepeat
   lda #BANK_48_TILES
   sta RAM_BANK
   lda #<RAM_WIN
   sta ZP_PTR_1
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   ldy #0
@tile_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @tile_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @next_tile_bank
   sta ZP_PTR_1+1
   bra @tile_loop
@next_tile_bank:
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   lda RAM_BANK
   inc
   cmp #BANK_416_TILES
   beq @load_palette
   sta RAM_BANK
   bra @tile_loop
@load_palette:
   lda #<pal_4bpp
   sta ZP_PTR_1
   lda #>pal_4bpp
   sta ZP_PTR_1+1
   VERA_SET_ADDR VRAM_palette
   ldy #0
@pal_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   cpy #32
   bne @pal_loop
   lda VERA_dc_video
   ora #$10
   sta VERA_dc_video ; enable layer 0
   jsr wait_key
slide_2bpp_8x8:
   lda #<title_8x8_2bpp
   sta ZP_PTR_1
   lda #>title_8x8_2bpp
   sta ZP_PTR_1+1
   jsr print_title
   lda VERA_dc_video
   and #$EF
   sta VERA_dc_video ; disable layer 0
   lda #$61 ; 128x64 2bpp tiles
   sta VERA_L0_config
   VERA_SET_ADDR TILE_SET
.repeat 16
   stz VERA_data0    ; clear tile 0
.endrepeat
   lda #BANK_28_TILES
   sta RAM_BANK
   lda #<RAM_WIN
   sta ZP_PTR_1
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   ldy #0
@tile_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @tile_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @next_tile_bank
   sta ZP_PTR_1+1
   bra @tile_loop
@next_tile_bank:
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   lda RAM_BANK
   inc
   cmp #BANK_216_TILES
   beq @load_palette
   sta RAM_BANK
   bra @tile_loop
@load_palette:
   lda #<pal_2bpp
   sta ZP_PTR_1
   lda #>pal_2bpp
   sta ZP_PTR_1+1
   VERA_SET_ADDR VRAM_palette
   ldy #0
@pal_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   cpy #8
   bne @pal_loop
   lda VERA_dc_video
   ora #$10
   sta VERA_dc_video ; enable layer 0
   jsr wait_key
slide_1bpp_8x8:
   lda #<title_8x8_1bpp
   sta ZP_PTR_1
   lda #>title_8x8_1bpp
   sta ZP_PTR_1+1
   jsr print_title
   lda VERA_dc_video
   and #$EF
   sta VERA_dc_video ; disable layer 0
   lda #$60 ; 128x64 1bpp tiles
   sta VERA_L0_config
   VERA_SET_ADDR TILE_SET
.repeat 8
   stz VERA_data0    ; clear tile 0
.endrepeat
   lda #BANK_18_TILES
   sta RAM_BANK
   lda #<RAM_WIN
   sta ZP_PTR_1
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   ldy #0
@tile_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @tile_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @next_tile_bank
   sta ZP_PTR_1+1
   bra @tile_loop
@next_tile_bank:
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   lda RAM_BANK
   inc
   cmp #BANK_116_TILES
   beq @load_palette
   sta RAM_BANK
   bra @tile_loop
@load_palette:
   lda #<pal_1bpp
   sta ZP_PTR_1
   lda #>pal_1bpp
   sta ZP_PTR_1+1
   VERA_SET_ADDR VRAM_palette
   ldy #0
@pal_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   cpy #4
   bne @pal_loop
   lda #$01
   ldx #$20
   ldy #0
   VERA_SET_ADDR (TILE_MAP+1),2
@map_loop:
   sta VERA_data0
   dey
   bne @map_loop
   dex
   bne @map_loop
   lda VERA_dc_video
   ora #$10
   sta VERA_dc_video ; enable layer 0
   jsr wait_key
slide_8bpp_8x16:
   lda #<title_8x16_8bpp
   sta ZP_PTR_1
   lda #>title_8x16_8bpp
   sta ZP_PTR_1+1
   jsr print_title
   lda VERA_dc_video
   and #$EF
   sta VERA_dc_video ; disable layer 0
   lda #$23 ; 128x32 8bpp tiles
   sta VERA_L0_config
   lda #$02
   sta VERA_L0_tilebase ; 8x16 tiles @ $00000
   VERA_SET_ADDR TILE_SET
.repeat 128
   stz VERA_data0    ; clear tile 0
.endrepeat
   lda #BANK_88_TILES
   sta RAM_BANK
   lda #<RAM_WIN
   sta ZP_PTR_1
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   ldy #0
@tile_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @tile_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @next_tile_bank
   sta ZP_PTR_1+1
   bra @tile_loop
@next_tile_bank:
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   lda RAM_BANK
   inc
   cmp #BANK_816_TILES
   beq @load_map
   sta RAM_BANK
   bra @tile_loop
@load_map:
   VERA_SET_ADDR TILE_MAP
   lda #BANK_816_MAP
   sta RAM_BANK
@map_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @map_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @load_palette
   sta ZP_PTR_1+1
   bra @map_loop
@load_palette:
   lda #<pal_8bpp
   sta ZP_PTR_1
   lda #>pal_8bpp
   sta ZP_PTR_1+1
   VERA_SET_ADDR VRAM_palette
   ldy #0
   ldx #2
@pal_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @pal_loop
   inc ZP_PTR_1+1
   dex
   bne @pal_loop
@done:
   lda VERA_dc_video
   ora #$10
   sta VERA_dc_video ; enable layer 0
   jsr wait_key
slide_4bpp_8x16:
   lda #<title_8x16_4bpp
   sta ZP_PTR_1
   lda #>title_8x16_4bpp
   sta ZP_PTR_1+1
   jsr print_title
   lda VERA_dc_video
   and #$EF
   sta VERA_dc_video ; disable layer 0
   lda #$22 ; 128x32 4bpp tiles
   sta VERA_L0_config
   VERA_SET_ADDR TILE_SET
.repeat 64
   stz VERA_data0    ; clear tile 0
.endrepeat
   lda #BANK_48_TILES
   sta RAM_BANK
   lda #<RAM_WIN
   sta ZP_PTR_1
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   ldy #0
@tile_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @tile_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @next_tile_bank
   sta ZP_PTR_1+1
   bra @tile_loop
@next_tile_bank:
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   lda RAM_BANK
   inc
   cmp #BANK_416_TILES
   beq @load_palette
   sta RAM_BANK
   bra @tile_loop
@load_palette:
   lda #<pal_4bpp
   sta ZP_PTR_1
   lda #>pal_4bpp
   sta ZP_PTR_1+1
   VERA_SET_ADDR VRAM_palette
   ldy #0
@pal_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   cpy #32
   bne @pal_loop
   lda VERA_dc_video
   ora #$10
   sta VERA_dc_video ; enable layer 0
   jsr wait_key
slide_2bpp_8x16:
   lda #<title_8x16_2bpp
   sta ZP_PTR_1
   lda #>title_8x16_2bpp
   sta ZP_PTR_1+1
   jsr print_title
   lda VERA_dc_video
   and #$EF
   sta VERA_dc_video ; disable layer 0
   lda #$21 ; 128x32 2bpp tiles
   sta VERA_L0_config
   VERA_SET_ADDR TILE_SET
.repeat 32
   stz VERA_data0    ; clear tile 0
.endrepeat
   lda #BANK_28_TILES
   sta RAM_BANK
   lda #<RAM_WIN
   sta ZP_PTR_1
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   ldy #0
@tile_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @tile_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @next_tile_bank
   sta ZP_PTR_1+1
   bra @tile_loop
@next_tile_bank:
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   lda RAM_BANK
   inc
   cmp #BANK_216_TILES
   beq @load_palette
   sta RAM_BANK
   bra @tile_loop
@load_palette:
   lda #<pal_2bpp
   sta ZP_PTR_1
   lda #>pal_2bpp
   sta ZP_PTR_1+1
   VERA_SET_ADDR VRAM_palette
   ldy #0
@pal_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   cpy #8
   bne @pal_loop
   lda VERA_dc_video
   ora #$10
   sta VERA_dc_video ; enable layer 0
   jsr wait_key
slide_1bpp_8x16:
   lda #<title_8x16_1bpp
   sta ZP_PTR_1
   lda #>title_8x16_1bpp
   sta ZP_PTR_1+1
   jsr print_title
   lda VERA_dc_video
   and #$EF
   sta VERA_dc_video ; disable layer 0
   lda #$20 ; 128x32 1bpp tiles
   sta VERA_L0_config
   VERA_SET_ADDR TILE_SET
.repeat 16
   stz VERA_data0    ; clear tile 0
.endrepeat
   lda #BANK_18_TILES
   sta RAM_BANK
   lda #<RAM_WIN
   sta ZP_PTR_1
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   ldy #0
@tile_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @tile_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @next_tile_bank
   sta ZP_PTR_1+1
   bra @tile_loop
@next_tile_bank:
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   lda RAM_BANK
   inc
   cmp #BANK_116_TILES
   beq @load_palette
   sta RAM_BANK
   bra @tile_loop
@load_palette:
   lda #<pal_1bpp
   sta ZP_PTR_1
   lda #>pal_1bpp
   sta ZP_PTR_1+1
   VERA_SET_ADDR VRAM_palette
   ldy #0
@pal_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   cpy #4
   bne @pal_loop
   lda #$01
   ldx #$10
   ldy #0
   VERA_SET_ADDR (TILE_MAP+1),2
@map_loop:
   sta VERA_data0
   dey
   bne @map_loop
   dex
   bne @map_loop
   lda VERA_dc_video
   ora #$10
   sta VERA_dc_video ; enable layer 0
   jsr wait_key
slide_8bpp_16x8:
   lda #<title_16x8_8bpp
   sta ZP_PTR_1
   lda #>title_16x8_8bpp
   sta ZP_PTR_1+1
   jsr print_title
   lda VERA_dc_video
   and #$EF
   sta VERA_dc_video ; disable layer 0
   lda #$53 ; 64x64 8bpp tiles
   sta VERA_L0_config
   lda #$01
   sta VERA_L0_tilebase ; 16x8 tiles @ $00000
   VERA_SET_ADDR TILE_SET
.repeat 128
   stz VERA_data0    ; clear tile 0
.endrepeat
   lda #BANK_816_TILES
   sta RAM_BANK
   lda #<RAM_WIN
   sta ZP_PTR_1
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   ldy #0
@tile_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @tile_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @next_tile_bank
   sta ZP_PTR_1+1
   bra @tile_loop
@next_tile_bank:
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   lda RAM_BANK
   inc
   cmp #BANK_88_MAP
   beq @load_map
   sta RAM_BANK
   bra @tile_loop
@load_map:
   VERA_SET_ADDR TILE_MAP
   lda #BANK_168_MAP
   sta RAM_BANK
@map_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @map_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @load_palette
   sta ZP_PTR_1+1
   bra @map_loop
@load_palette:
   lda #<pal_8bpp
   sta ZP_PTR_1
   lda #>pal_8bpp
   sta ZP_PTR_1+1
   VERA_SET_ADDR VRAM_palette
   ldy #0
   ldx #2
@pal_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @pal_loop
   inc ZP_PTR_1+1
   dex
   bne @pal_loop
@done:
   lda VERA_dc_video
   ora #$10
   sta VERA_dc_video ; enable layer 0
   jsr wait_key
slide_4bpp_16x8:
   lda #<title_16x8_4bpp
   sta ZP_PTR_1
   lda #>title_16x8_4bpp
   sta ZP_PTR_1+1
   jsr print_title
   lda VERA_dc_video
   and #$EF
   sta VERA_dc_video ; disable layer 0
   lda #$52 ; 64x64 4bpp tiles
   sta VERA_L0_config
   VERA_SET_ADDR TILE_SET
.repeat 64
   stz VERA_data0    ; clear tile 0
.endrepeat
   lda #BANK_416_TILES
   sta RAM_BANK
   lda #<RAM_WIN
   sta ZP_PTR_1
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   ldy #0
@tile_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @tile_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @next_tile_bank
   sta ZP_PTR_1+1
   bra @tile_loop
@next_tile_bank:
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   lda RAM_BANK
   inc
   cmp #BANK_88_TILES
   beq @load_palette
   sta RAM_BANK
   bra @tile_loop
@load_palette:
   lda #<pal_4bpp
   sta ZP_PTR_1
   lda #>pal_4bpp
   sta ZP_PTR_1+1
   VERA_SET_ADDR VRAM_palette
   ldy #0
@pal_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   cpy #32
   bne @pal_loop
   lda VERA_dc_video
   ora #$10
   sta VERA_dc_video ; enable layer 0
   jsr wait_key
slide_2bpp_16x8:
   lda #<title_16x8_2bpp
   sta ZP_PTR_1
   lda #>title_16x8_2bpp
   sta ZP_PTR_1+1
   jsr print_title
   lda VERA_dc_video
   and #$EF
   sta VERA_dc_video ; disable layer 0
   lda #$51 ; 64x64 2bpp tiles
   sta VERA_L0_config
   VERA_SET_ADDR TILE_SET
.repeat 32
   stz VERA_data0    ; clear tile 0
.endrepeat
   lda #BANK_216_TILES
   sta RAM_BANK
   lda #<RAM_WIN
   sta ZP_PTR_1
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   ldy #0
@tile_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @tile_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @next_tile_bank
   sta ZP_PTR_1+1
   bra @tile_loop
@next_tile_bank:
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   lda RAM_BANK
   inc
   cmp #BANK_48_TILES
   beq @load_palette
   sta RAM_BANK
   bra @tile_loop
@load_palette:
   lda #<pal_2bpp
   sta ZP_PTR_1
   lda #>pal_2bpp
   sta ZP_PTR_1+1
   VERA_SET_ADDR VRAM_palette
   ldy #0
@pal_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   cpy #8
   bne @pal_loop
   lda VERA_dc_video
   ora #$10
   sta VERA_dc_video ; enable layer 0
   jsr wait_key
slide_1bpp_16x8:
   lda #<title_16x8_1bpp
   sta ZP_PTR_1
   lda #>title_16x8_1bpp
   sta ZP_PTR_1+1
   jsr print_title
   lda VERA_dc_video
   and #$EF
   sta VERA_dc_video ; disable layer 0
   lda #$50 ; 64x64 1bpp tiles
   sta VERA_L0_config
   VERA_SET_ADDR TILE_SET
.repeat 16
   stz VERA_data0    ; clear tile 0
.endrepeat
   lda #BANK_116_TILES
   sta RAM_BANK
   lda #<RAM_WIN
   sta ZP_PTR_1
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   ldy #0
@tile_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @tile_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @next_tile_bank
   sta ZP_PTR_1+1
   bra @tile_loop
@next_tile_bank:
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   lda RAM_BANK
   inc
   cmp #BANK_28_TILES
   beq @load_palette
   sta RAM_BANK
   bra @tile_loop
@load_palette:
   lda #<pal_1bpp
   sta ZP_PTR_1
   lda #>pal_1bpp
   sta ZP_PTR_1+1
   VERA_SET_ADDR VRAM_palette
   ldy #0
@pal_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   cpy #4
   bne @pal_loop
   lda #$01
   ldx #$10
   ldy #0
   VERA_SET_ADDR (TILE_MAP+1),2
@map_loop:
   sta VERA_data0
   dey
   bne @map_loop
   dex
   bne @map_loop
   lda VERA_dc_video
   ora #$10
   sta VERA_dc_video ; enable layer 0
   jsr wait_key
slide_8bpp_16x16:
   lda #<title_16x16_8bpp
   sta ZP_PTR_1
   lda #>title_16x16_8bpp
   sta ZP_PTR_1+1
   jsr print_title
   lda VERA_dc_video
   and #$EF
   sta VERA_dc_video ; disable layer 0
   lda #$13 ; 64x32 8bpp tiles
   sta VERA_L0_config
   lda #$03
   sta VERA_L0_tilebase ; 16x16 tiles @ $00000
   VERA_SET_ADDR TILE_SET
.repeat 256
   stz VERA_data0    ; clear tile 0
.endrepeat
   lda #BANK_816_TILES
   sta RAM_BANK
   lda #<RAM_WIN
   sta ZP_PTR_1
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   ldy #0
@tile_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @tile_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @next_tile_bank
   sta ZP_PTR_1+1
   bra @tile_loop
@next_tile_bank:
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   lda RAM_BANK
   inc
   cmp #BANK_88_MAP
   beq @load_map
   sta RAM_BANK
   bra @tile_loop
@load_map:
   VERA_SET_ADDR TILE_MAP
   lda #BANK_1616_MAP
   sta RAM_BANK
@map_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @map_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @load_palette
   sta ZP_PTR_1+1
   bra @map_loop
@load_palette:
   lda #<pal_8bpp
   sta ZP_PTR_1
   lda #>pal_8bpp
   sta ZP_PTR_1+1
   VERA_SET_ADDR VRAM_palette
   ldy #0
   ldx #2
@pal_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @pal_loop
   inc ZP_PTR_1+1
   dex
   bne @pal_loop
@done:
   lda VERA_dc_video
   ora #$10
   sta VERA_dc_video ; enable layer 0
   jsr wait_key
slide_4bpp_16x16:
   lda #<title_16x16_4bpp
   sta ZP_PTR_1
   lda #>title_16x16_4bpp
   sta ZP_PTR_1+1
   jsr print_title
   lda VERA_dc_video
   and #$EF
   sta VERA_dc_video ; disable layer 0
   lda #$12 ; 64x32 4bpp tiles
   sta VERA_L0_config
   VERA_SET_ADDR TILE_SET
.repeat 128
   stz VERA_data0    ; clear tile 0
.endrepeat
   lda #BANK_416_TILES
   sta RAM_BANK
   lda #<RAM_WIN
   sta ZP_PTR_1
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   ldy #0
@tile_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @tile_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @next_tile_bank
   sta ZP_PTR_1+1
   bra @tile_loop
@next_tile_bank:
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   lda RAM_BANK
   inc
   cmp #BANK_88_TILES
   beq @load_palette
   sta RAM_BANK
   bra @tile_loop
@load_palette:
   lda #<pal_4bpp
   sta ZP_PTR_1
   lda #>pal_4bpp
   sta ZP_PTR_1+1
   VERA_SET_ADDR VRAM_palette
   ldy #0
@pal_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   cpy #32
   bne @pal_loop
   lda VERA_dc_video
   ora #$10
   sta VERA_dc_video ; enable layer 0
   jsr wait_key
slide_2bpp_16x16:
   lda #<title_16x16_2bpp
   sta ZP_PTR_1
   lda #>title_16x16_2bpp
   sta ZP_PTR_1+1
   jsr print_title
   lda VERA_dc_video
   and #$EF
   sta VERA_dc_video ; disable layer 0
   lda #$51 ; 64x32 2bpp tiles
   sta VERA_L0_config
   VERA_SET_ADDR TILE_SET
.repeat 64
   stz VERA_data0    ; clear tile 0
.endrepeat
   lda #BANK_216_TILES
   sta RAM_BANK
   lda #<RAM_WIN
   sta ZP_PTR_1
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   ldy #0
@tile_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @tile_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @next_tile_bank
   sta ZP_PTR_1+1
   bra @tile_loop
@next_tile_bank:
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   lda RAM_BANK
   inc
   cmp #BANK_48_TILES
   beq @load_palette
   sta RAM_BANK
   bra @tile_loop
@load_palette:
   lda #<pal_2bpp
   sta ZP_PTR_1
   lda #>pal_2bpp
   sta ZP_PTR_1+1
   VERA_SET_ADDR VRAM_palette
   ldy #0
@pal_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   cpy #8
   bne @pal_loop
   lda VERA_dc_video
   ora #$10
   sta VERA_dc_video ; enable layer 0
   jsr wait_key
slide_1bpp_16x16:
   lda #<title_16x16_1bpp
   sta ZP_PTR_1
   lda #>title_16x16_1bpp
   sta ZP_PTR_1+1
   jsr print_title
   lda VERA_dc_video
   and #$EF
   sta VERA_dc_video ; disable layer 0
   lda #$10 ; 64x32 1bpp tiles
   sta VERA_L0_config
   VERA_SET_ADDR TILE_SET
.repeat 32
   stz VERA_data0    ; clear tile 0
.endrepeat
   lda #BANK_116_TILES
   sta RAM_BANK
   lda #<RAM_WIN
   sta ZP_PTR_1
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   ldy #0
@tile_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   bne @tile_loop
   lda ZP_PTR_1+1
   inc
   cmp #>(RAM_WIN+RAM_WIN_SIZE)
   beq @next_tile_bank
   sta ZP_PTR_1+1
   bra @tile_loop
@next_tile_bank:
   lda #>RAM_WIN
   sta ZP_PTR_1+1
   lda RAM_BANK
   inc
   cmp #BANK_28_TILES
   beq @load_palette
   sta RAM_BANK
   bra @tile_loop
@load_palette:
   lda #<pal_1bpp
   sta ZP_PTR_1
   lda #>pal_1bpp
   sta ZP_PTR_1+1
   VERA_SET_ADDR VRAM_palette
   ldy #0
@pal_loop:
   lda (ZP_PTR_1),y
   sta VERA_data0
   iny
   cpy #4
   bne @pal_loop
   lda #$01
   ldx #$05
   ldy #0
   VERA_SET_ADDR (TILE_MAP+1),2
@map_loop:
   sta VERA_data0
   dey
   bne @map_loop
   dex
   bne @map_loop
   lda VERA_dc_video
   ora #$10
   sta VERA_dc_video ; enable layer 0
   jsr wait_key
   jmp slide_8bpp_8x8
   rts


print_filename: ; ZP_PTR_1 = filename string, A = len
   phx
   phy
   tax
   ldy #0
@loop:
   lda (ZP_PTR_1),y
   jsr CHROUT
   iny
   dex
   bne @loop
   lda #RETURN_CHAR
   jsr CHROUT
   ply
   plx
   rts

wait_key:
   jsr GETIN
   cmp #0
   beq wait_key
   rts

print_title: ; ZP_PTR_1 = null-terminated title string
   ldy #0
@loop:
   lda (ZP_PTR_1),y
   cmp #0
   beq @return
   jsr CHROUT
   iny
   bra @loop
@return:
   rts
