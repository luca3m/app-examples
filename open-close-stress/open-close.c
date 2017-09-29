#include <stdio.h>

void main() {
  for(;;)
  {
          FILE* f = fopen("/dev/null", "r");
          fclose(f);
  }
}