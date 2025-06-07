// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "TagKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "TagKit",
            targets: ["TagKit"]
        )
    ],
    targets: [
        .target(
            name: "TagKit"
        ),
        .testTarget(
            name: "TagKitTests",
            dependencies: ["TagKit"]
        )
    ]
)
