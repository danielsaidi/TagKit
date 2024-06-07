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
            targets: ["TagKit"]
        )
    ],
    targets: [
        .target(
            name: "TagKit",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "TagKitTests",
            dependencies: ["TagKit"]
        )
    ]
)
