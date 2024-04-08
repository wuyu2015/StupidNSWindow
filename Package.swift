// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StupidNSWindow",
    platforms: [
        .macOS(.v10_11),
    ],
    products: [
        .library(
            name: "StupidNSWindow",
            targets: ["StupidNSWindow"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "StupidNSWindow",
            dependencies: []),
        .testTarget(
            name: "StupidNSWindowTests",
            dependencies: ["StupidNSWindow"]),
    ],
    swiftLanguageVersions: [.v5]
)
