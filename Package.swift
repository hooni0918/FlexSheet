// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FlexSheet",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "FlexSheet",
            targets: ["FlexSheet"]),
    ],
    targets: [
        .target(
            name: "FlexSheet",
            dependencies: []),
        .testTarget(
            name: "FlexSheetTests",
            dependencies: ["FlexSheet"]),
    ]
)
