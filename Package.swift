// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SearchKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SearchKit",
            targets: ["SearchKit"]),
        .executable(
            name: "SearchKitPlayground",
            targets: ["SearchKitPlayground"]),
    ],
    dependencies: [
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SearchKit",
            path: "Sources"),
        .executableTarget(
            name: "SearchKitPlayground",
            dependencies: [
                "SearchKit"
            ],
            path: "Examples/SearchKitPlayground"),
        .testTarget(
            name: "SearchKitTests",
            dependencies: [
                "SearchKit"
            ]
        ),
    ]
)
