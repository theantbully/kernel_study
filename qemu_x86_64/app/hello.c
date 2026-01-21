// Ref video: https://www.youtube.com/watch?v=ZlZDWeVL2LI
#include<unistd.h>
int main()
{
   write(1, "nice!\n", 6);
   _exit(0xa4);
}

