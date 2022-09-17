#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

void main(int argc, char **argv) {
   FILE *ofp;
   int orig_width = 544;
   int orig_height = 64;
   int start_col;
   int end_col;
   int start_row;
   int end_row;
   uint8_t odata[2];
   int i,j;
   int tile_index;

   if (argc < 2) {
      printf("Usage: %s [map filename base] [original width] [original height]...\n", argv[0]);
      return;
   }

   ofp = fopen(argv[1],"wb");

   if (argc >= 3) {
      orig_width = atoi(argv[2]);
   }

   if (argc >= 4) {
      orig_height = atoi(argv[3]);
   }

   /* 16x16 tiles */
   start_col = (640 - orig_width) / 32;
   end_col = (640 - start_col + orig_width) / 16 - 1;
   start_row = (480 - orig_height) / 32;
   end_row = (480 - start_row + orig_height) / 16 - 1;
   odata[0] = 0;
   odata[1] = 0;

   for (i = 0; i < start_row; i++) {
      for (j = 0; j < 640/16; j++) {
         fwrite(odata,1,2,ofp);
      }
   }

   for (i = start_row; i <= end_row; i++) {
      for (j = 0; j < start_col; j++) {
         fwrite(odata,1,2,ofp);
      }
      
   }


}
