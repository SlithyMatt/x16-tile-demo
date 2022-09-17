#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

void main(int argc, char **argv) {
   FILE *ifp;
   FILE *ofp;

   int address;
   uint8_t idata[8];
   uint8_t odata[2];
   int i;

   if (argc < 3) {
      printf("Usage: %s [1bpp output] [8bpp input]...\n", argv[0]);
      return;
   }

   ofp = fopen(argv[1], "wb");
   if (ofp == NULL) {
      printf("Error opening %s for writing\n", argv[2]);
      return;
   }

   // set default load address to 0x0000
   address = 0x0000;

   odata[0] = (uint8_t) (address & 0x00FF);
   odata[1] = (uint8_t) ((address & 0xFF00) >> 8);
   fwrite(odata,1,2,ofp);

   for (int i = 2; i < argc; i++) {
      ifp = fopen(argv[i], "rb");
      if (ifp == NULL) {
         printf("Error opening %s for reading\n", argv[i]);
         return;
      }

      while (!feof(ifp)) {
         if (fread(idata,1,8,ifp) > 0) {
            odata[0] = (idata[0] & 0x1) << 7;
            odata[0] |= (idata[1] & 0x1) << 6;
            odata[0] |= (idata[2] & 0x1) << 5;
            odata[0] |= (idata[3] & 0x1) << 4;
            odata[0] |= (idata[4] & 0x1) << 3;
            odata[0] |= (idata[5] & 0x1) << 2;
            odata[0] |= (idata[6] & 0x1) << 1;
            odata[0] |= idata[7] & 0x1;
            fwrite(odata,1,1,ofp);
         }
      }
      fclose(ifp);
   }
   fclose(ofp);
}
