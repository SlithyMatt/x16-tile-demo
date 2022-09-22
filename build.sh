#!/bin/sh

gcc -o make4bitbin.exe make4bitbin.c
gcc -o pal12bit.exe pal12bit.c 
gcc -o make2bitbin.exe make2bitbin.c
gcc -o make1bitbin.exe make1bitbin.c
gcc -o retile.exe retile.c 
gcc -o buildmaps.exe buildmaps.c 

cl65 -t cx16 -o TILES.PRG -l tiledemo.list tiledemo.asm 
