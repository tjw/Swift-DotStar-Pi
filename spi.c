#include <stdio.h>
#include <sys/ioctl.h>
#include <linux/spi/spidev.h>

int main(int argc, char *argv[])
{

  printf("let SPI_NO_CS:UInt = %d\n", SPI_NO_CS);
  printf("let SPI_MODE_0:UInt = %d\n", SPI_MODE_0);
  printf("let SPI_IOC_WR_MODE:UInt = 0x%x\n", SPI_IOC_WR_MODE);
  printf("let SPI_IOC_WR_MAX_SPEED_HZ:UInt = 0x%x\n", SPI_IOC_WR_MAX_SPEED_HZ);

  return 0;
}
