#include <sys/time.h>
#include <unistd.h>
#include <sys/syscall.h>

int main()
{
  for(;;)
  {
    struct timeval tv;
    // gettimeofday(&tv, 0);
    syscall(SYS_gettimeofday, &tv, 0);
  }
}
