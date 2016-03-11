// This will locate the module.modulemap in our `modules` directory and will build a Swift module based on <linux/spidev.h>

import Glibc
import SwiftSPI

class DotStar {
    enum Error: ErrorType {
        case CannotOpen
    }

    let pixelCount:Int
    let bitrate:Int32

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

    init(pixelCount:Int, bitrate:Int32 = 8000000) {
        self.pixelCount = pixelCount
        self.bitrate = bitrate

	// Initialize the packed pixels all to 0xff000000
	self.bytes = Array<UInt8>(count: 4*pixelCount, repeatedValue: 0)
	for pixelIndex in 0..<pixelCount {
	    self.bytes[4*pixelIndex + 0] = 0xff
	}
    }

    func begin() throws {
        if fd != -1 {
	    abort() // Throw an error
	}
	fd = open("/dev/spidev0.0", O_RDWR)
	guard fd >= 0 else {
	    throw Error.CannotOpen
	}

        var mode:CInt = Swift_SPI_MODE_0 | Swift_SPI_NO_CS
	Swift_ioctl_v1(fd, UInt(Swift_SPI_IOC_WR_MODE), &mode)
        Swift_ioctl_i1(fd, UInt(Swift_SPI_IOC_WR_MAX_SPEED_HZ), bitrate)
    }
}

