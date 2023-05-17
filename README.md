# SwiftMKMap

## Installation
### SwiftPM
Add this package to `Package.swift`
```
let package = Package(
    dependencies: [
        .package(url: "https://github.com/kantacky/SwiftMKMap", .upToNextMajor(from: "0.1.0"))
    ],
    targets: [
        .target(
            name: "<your-target-name>",
            dependencies: [
                .product(name: "SwiftMKMap", package: "SwiftMKMap"),
                .product(name: "ExtendedMKModels", package: "SwiftMKMap")
            ]
        )
    ]
)
```

### Xcode
See [Xcode Documentation](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app)

## License
This library is released under the MIT license. See [LICENSE](LICENSE) for details.
