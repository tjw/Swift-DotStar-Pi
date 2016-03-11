#include <sys/ioctl.h>
#include <linux/spi/spidev.h>

#include "spi.h"

int Swift_SPI_NO_CS = SPI_NO_CS;
int Swift_SPI_MODE_0 = SPI_MODE_0;
int Swift_SPI_IOC_WR_MODE = SPI_IOC_WR_MODE;
int Swift_SPI_IOC_WR_MAX_SPEED_HZ = SPI_IOC_WR_MAX_SPEED_HZ;

int Swift_ioctl_v1(int fd, unsigned long request, void *arg)
{
  return ioctl(fd, request, arg);
}

int Swift_ioctl_i1(int fd, unsigned long request, int arg)
{
  return ioctl(fd, request, arg);
}
