// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "CoreNetworking",
    platforms: [
        .macOS(.v12),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "CoreNetworking",
            targets: ["CoreNetworking"]),
    ],
    targets: [
        .target(
            name: "CoreNetworking"),
        .testTarget(
            name: "CoreNetworkingTests",
            dependencies: ["CoreNetworking"]
        ),
    ]
)
