// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "LRCLIBSwift",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .watchOS(.v9),
        .tvOS(.v16),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "LRCLIBSwift",
            targets: ["LRCLIBSwift"]),
    ],
    targets: [
        .target(
            name: "LRCLIBSwift"),
        .testTarget(
            name: "LRCLIBSwiftTests",
            dependencies: ["LRCLIBSwift"]
        ),

    ],
    swiftLanguageModes: [.v6]
)
