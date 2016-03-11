

ALL: bin/onoff

bin/onoff: bin module-cache SwiftSPI/module.modulemap SwiftSPI/libspi.a examples/onoff/main.swift DotStar.swift
	swiftc -ISwiftSPI -LSwiftSPI -module-cache-path module-cache examples/onoff/main.swift DotStar.swift -o bin/onoff

SwiftSPI/libspi.a: SwiftSPI/spi.h SwiftSPI/spi.c
	clang -Wall SwiftSPI/spi.c -c -o SwiftSPI/spi.o
	ar -cr SwiftSPI/libspi.a SwiftSPI/spi.o

module-cache:
	mkdir -p module-cache

bin:
	mkdir -p bin

clean:
	rm -rf *.a *.o module-cache
