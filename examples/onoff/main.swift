import Glibc

let pixelCount = 10
let dotstar = DotStar(pixelCount:pixelCount)

let red = DotStar.Pixel(r:255, g:0, b:0)
let green = DotStar.Pixel(r:0, g:255, b:0)
let blue = DotStar.Pixel(r:0, g:0, b:255)

try! dotstar.begin()

var step: Double = 0.0

// Map -1..1 to 0..255
func unitToComponent(unit:Double) -> UInt8 {
    let scaled = 255 * 0.5 * (unit + 1)
    if scaled < 0 {
        return 0
    }
    if scaled > 255 {
        return 255
    }
    return UInt8(scaled)
}

while (true) {
    for pixelIndex in 0..<pixelCount {
        let theta = Double(pixelIndex) * (2*M_PI / Double(pixelCount))
        let red = sin(theta + step)
	let green = cos(2*theta + step)
	let blue = -sin(0.5 * theta - step)
	
	let pixel = DotStar.Pixel(r: unitToComponent(red), g: unitToComponent(green), b: unitToComponent(blue))
	dotstar[pixelIndex] = pixel
    }

    try! dotstar.write()
    step += 0.001
}
