
// Wrappers to expose an API that Swift can digest

// Swift doesn't understand C-style varargs. The Glic module defines these sorts of wrappers for open() and fcntl() but not ioctl().
extern int Swift_ioctl_v1(int fd, unsigned long request, void *arg);
extern int Swift_ioctl_i1(int fd, unsigned long request, int arg);

extern int Swift_SPI_NO_CS;
extern int Swift_SPI_MODE_0;
extern int Swift_SPI_IOC_WR_MODE;
extern int Swift_SPI_IOC_WR_MAX_SPEED_HZ;


