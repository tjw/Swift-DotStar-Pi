#include "spi.h"

unsigned long Swift_SPI_NO_CS = SPI_NO_CS;
unsigned long Swift_SPI_MODE_0 = SPI_MODE_0;
unsigned long Swift_SPI_IOC_WR_MODE = SPI_IOC_WR_MODE;
unsigned long Swift_SPI_IOC_WR_MAX_SPEED_HZ = SPI_IOC_WR_MAX_SPEED_HZ;

unsigned long Swift_SPI_IOC_MESSAGE(int arg)
{
  return SPI_IOC_MESSAGE(arg);
}

int Swift_ioctl_v1(int fd, unsigned long request, void *arg)
{
  return ioctl(fd, request, arg);
}

int Swift_ioctl_i1(int fd, unsigned long request, int arg)
{
  return ioctl(fd, request, arg);
}

__u64 Swift_SPI_pointer_to_integer(void *ptr)
{
  return (__u64)ptr;
}
