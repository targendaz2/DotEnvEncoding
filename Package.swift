// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DotEnvEncoding",
    platforms: [
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "DotEnvEncoding",
            targets: ["DotEnvEncoding"],
        )
    ],
    targets: [
        .target(
            name: "DotEnvEncoding",
        ),
        .testTarget(
            name: "DotEnvEncodingTests",
            dependencies: ["DotEnvEncoding"],
        ),
    ]
)
