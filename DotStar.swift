// This will locate the module.modulemap in our `modules` directory and will build a Swift module based on <linux/spidev.h>

import SPI

class DotStar {
    let pixelCount:Int
    let bitrate:Int

    var fd:CInt? = -1

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

    init(pixelCount:Int, bitrate:Int = 8000000) {
        self.pixelCount = pixelCount
        self.bitrate = bitrate

	pixels = Array<UInt8>(count: 4*pixelCount, repeatedValue: 0)
	for pixelIndex in 0..<pixelCount {
	    pixels[4*pixelIndex + 0] = 0xff
	}

    }
}

