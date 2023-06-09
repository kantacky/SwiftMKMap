// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "SwiftMKMap",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
        .tvOS(.v16)
    ],
    products: [
        .library(
            name: "SwiftMKMap",
            targets: ["SwiftMKMap"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/realm/SwiftLint", .upToNextMajor(from: "0.52.0"))
    ],
    targets: [
        .target(
            name: "SwiftMKMap",
            dependencies: [
                "ExtendedMKModels"
            ],
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
        ),
        .target(
            name: "ExtendedMKModels",
            dependencies: [],
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
        )
    ]
)
