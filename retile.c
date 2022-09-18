#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

void main(int argc, char **argv) {
   FILE *ifp;
   FILE *ofp;

   int address;
   int iwidth;
   int owidth;
   uint8_t idata[640*480];
   int iheight;
   int x,y;

   if (argc < 5) {
      printf("Usage: %s [input bitmap] [input width] [output bitmap] [output width]\n", argv[0]);
      return;
   }

   ifp = fopen(argv[1], "rb");
   if (ifp == NULL) {
      printf("Error opening %s for reading\n", argv[1]);
      return;
   }

   iwidth = atoi(argv[2]);

   ofp = fopen(argv[3], "wb");
   if (ofp == NULL) {
      printf("Error opening %s for writing\n", argv[3]);
      return;
   }

   owidth = atoi(argv[4]);

   if (owidth < 8) {
      printf("Output tile width must be at least 8 pixels\n");
      return;
   }

   if (iwidth % owidth != 0) {
      printf("Input tile width must be even multiple of %d\n", owidth);
      return;
   }

   x = 0;
   y = 0;
   while (!feof(ifp)) {
      fread(&idata[x+y*iwidth],1,owidth,ifp);
      x += owidth;
      if (x == iwidth) {
         x = 0;
         y++;
      }
   }
   fclose(ifp);

   iheight = y;

   for (x = 0; x < iwidth; x += owidth) {
      for (y = 0; y < iheight; y++) {
         fwrite(&idata[x+y*iwidth],1,owidth,ofp);
      }
   }

   fclose(ofp);
}
