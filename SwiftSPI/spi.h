
// Wrappers to expose an API that Swift can digest

// We do include the system header here so that we get the spi_ioc_transfer struct
#include <sys/ioctl.h>
#include <linux/types.h>
#include <linux/spi/spidev.h>

// Swift doesn't understand C-style varargs. The Glic module defines these sorts of wrappers for open() and fcntl() but not ioctl().
extern int Swift_ioctl_v1(int fd, unsigned long request, void *arg);
extern int Swift_ioctl_i1(int fd, unsigned long request, int arg);

extern unsigned long Swift_SPI_NO_CS;
extern unsigned long Swift_SPI_MODE_0;
extern unsigned long Swift_SPI_IOC_WR_MODE;
extern unsigned long Swift_SPI_IOC_WR_MAX_SPEED_HZ;

extern unsigned long Swift_SPI_IOC_MESSAGE(int arg);

// The spi_ioc_transfer strict has a __u64 for the data pointer and Swift doesn't like converting between pointer and integers.
extern __u64 Swift_SPI_pointer_to_integer(void *ptr);
