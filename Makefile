
onoff: module-cache modules/module.modulemap examples/onoff/main.swift DotStar.swift
	swiftc -Imodules -module-cache-path module-cache examples/onoff/main.swift DotStar.swift -o onoff

module-cache:
	mkdir -p module-cache
