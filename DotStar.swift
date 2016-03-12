// This will locate the module.modulemap in our `modules` directory and will build a Swift module based on <linux/spidev.h>

import Glibc
import SwiftSPI

class DotStar {
    enum Error: ErrorType {
        case CannotOpen
    }

    let pixelCount:Int
    let bitrate:UInt32

    var fd:CInt = -1

    // TODO: Make the order configurable? Default xBRG.
    private let rOffset = 2
    private let gOffset = 3
    private let bOffset = 1

    // The public-facing pixel
    struct Pixel {
        let r:UInt8
        let g:UInt8
        let b:UInt8
    }

    private var bytes:[UInt8]

    init(pixelCount:Int, bitrate:UInt32 = 8000000) {
        self.pixelCount = pixelCount
        self.bitrate = bitrate

        // Initialize the packed pixels all to 0xff000000
        self.bytes = Array<UInt8>(count: 4*pixelCount, repeatedValue: 0)
        for pixelIndex in 0..<pixelCount {
            self.bytes[4*pixelIndex + 0] = 0xff
        }
    }

    deinit {
        end()
    }

    func begin() throws {
        if fd != -1 {
            abort() // Throw an error
        }
        fd = open("/dev/spidev0.0", O_RDWR)
        guard fd >= 0 else {
            throw Error.CannotOpen
        }

        var mode:CUnsignedLong = Swift_SPI_MODE_0 | Swift_SPI_NO_CS
        Swift_ioctl_v1(fd, Swift_SPI_IOC_WR_MODE, &mode)
        Swift_ioctl_i1(fd, Swift_SPI_IOC_WR_MAX_SPEED_HZ, Int32(bitrate))
    }

    func end() {
        if fd >= 0 {
            close(fd)
            fd = -1
        }
    }

    subscript(pixelIndex:Int) -> Pixel {
        get {
            let r = bytes[4*pixelIndex + rOffset]
            let g = bytes[4*pixelIndex + gOffset]
            let b = bytes[4*pixelIndex + bOffset]
            return Pixel(r:r, g:g, b:b)
        }
        set {
            bytes[4*pixelIndex + rOffset] = newValue.r
            bytes[4*pixelIndex + gOffset] = newValue.g
            bytes[4*pixelIndex + bOffset] = newValue.b
        }
    }

    func write() throws {
        var xfer = Array<spi_ioc_transfer>()

        var header = make_xfer()
        header.len = 4
        xfer.append(header)

        var data = make_xfer()
        data.tx_buf = Swift_SPI_pointer_to_integer(&bytes) // TODO: Use the unsafe buffer methods? Maybe not needed since this is a member of us and we are still alive
        data.len = UInt32(4*pixelCount)
        xfer.append(data)

        var trailer = make_xfer()
        trailer.len = (UInt32(pixelCount) + 15) / 16
        xfer.append(trailer)

        Swift_ioctl_v1(fd, Swift_SPI_IOC_MESSAGE(3), &xfer)
    }

    private func make_xfer() -> spi_ioc_transfer {
        return spi_ioc_transfer(tx_buf: 0, rx_buf:0, len: 0, speed_hz:bitrate,
        delay_usecs: 0, bits_per_word: 8, cs_change: 0, tx_nbits: 0, rx_nbits: 0, pad: 0)
    }
}

// Non-core functions
extension DotStar {
    func clear() {
        let off = Pixel(r:0, g:0, b:0)
        for pixelIndex in 0..<pixelCount {
            self[pixelIndex] = off
        }
    }
}
