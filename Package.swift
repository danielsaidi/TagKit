// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "TagKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v6)
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
