// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "TagKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v10),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "TagKit",
            targets: ["TagKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "TagKit",
            dependencies: []),
        .testTarget(
            name: "TagKitTests",
            dependencies: ["TagKit"]),
    ]
)
