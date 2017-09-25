#include <sys/time.h>

int main()
{
  for(;;)
  {
    struct timeval tv;
    gettimeofday(&tv, 0);
  }
}
