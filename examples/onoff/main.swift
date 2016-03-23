import Glibc

let dotstar = DotStar(pixelCount:1)
print("dotstar = \(dotstar)")

let red = DotStar.Pixel(r:255, g:0, b:0)
let green = DotStar.Pixel(r:0, g:255, b:0)
let blue = DotStar.Pixel(r:0, g:0, b:255)

try! dotstar.begin()

while (true) {
    dotstar[0] = red
    try! dotstar.write()
    sleep(1)

    dotstar[0] = green
    try! dotstar.write()
    sleep(1)

    dotstar[0] = blue
    try! dotstar.write()
    sleep(1)
}
