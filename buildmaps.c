#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

void buildmap(int orig_width, int orig_height, int twidth, int theight) {
   FILE *ofp;
   char ofn[13];
   int start_col;
   int num_cols;
   int start_row;
   int num_rows;
   uint8_t odata[2];
   int i,j;
   int tile_index;
   
   sprintf(ofn,"MAP%02d%02d.BIN",twidth,theight);
   ofp = fopen(ofn,"wb");
   odata[0] = 0;
   odata[1] = 0;
   fwrite(odata,1,2,ofp); // set header to zero
 
   start_col = (640 - orig_width) / (twidth*2);
   num_cols = orig_width / twidth;
   start_row = (480 - orig_height) / (theight*2);
   num_rows = orig_height / theight;

   for (i = 0; i < start_row; i++) {
      for (j = 0; j < 640/twidth; j++) {
         fwrite(odata,1,2,ofp);
      }
   }

   for (i = start_row; i < start_row+num_rows; i++) {
      for (j = 0; j < start_col; j++) {
         fwrite(odata,1,2,ofp);
      }
      tile_index = 1 + i - start_row;
      for (j = start_col; j < start_col+num_cols; j++) {
         odata[0] = tile_index & 0xFF;
         odata[1] = (tile_index & 0x300) >> 8;
         fwrite(odata,1,2,ofp);
         tile_index += num_rows;
      }
      odata[0] = 0;
      odata[1] = 0;
      for (j = start_col+num_cols; j < 640/twidth; j++) {
         fwrite(odata,1,2,ofp);
      }
   }

   for (i = start_row+num_rows; i < 480/theight; i++) {
      for (j = 0; j < 640/twidth; j++) {
         fwrite(odata,1,2,ofp);
      }
   }

   fclose(ofp);
}


void main(int argc, char **argv) {
   int orig_width = 544;
   int orig_height = 64;

   if (argc >= 2) {
      orig_width = atoi(argv[2]);
   }

   if (argc >= 3) {
      orig_height = atoi(argv[3]);
   }

   buildmap(orig_width, orig_height,8,8);
   buildmap(orig_width, orig_height,8,16);
   buildmap(orig_width, orig_height,16,8);
   buildmap(orig_width, orig_height,16,16);
}
