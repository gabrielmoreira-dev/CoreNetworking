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
            targets: ["CoreNetworking"]
        ),
        .library(
            name: "CoreNetworkingTestUtils",
            targets: ["CoreNetworkingTestUtils"]
        )
    ],
    targets: [
        .target(
            name: "CoreNetworking"
        ),
        .target(
            name: "CoreNetworkingTestUtils",
            dependencies: ["CoreNetworking"],
            path: "Sources/TestUtils"
        ),
        .testTarget(
            name: "CoreNetworkingTests",
            dependencies: ["CoreNetworking", "CoreNetworkingTestUtils"]
        ),
    ]
)
