

onoff: module-cache modules/module.modulemap examples/onoff/main.swift DotStar.swift SPI.swift
	swiftc -Imodules -module-cache-path module-cache examples/onoff/main.swift DotStar.swift SPI.swift -o onoff

SPI.swift: spi.c
	cc -Wall spi.c -o spi
	./spi > SPI.swift

module-cache:
	mkdir -p module-cache
