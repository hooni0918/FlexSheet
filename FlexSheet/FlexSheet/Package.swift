//
//  Package.swift
//  FlexSheet
//
//  Created by 이지훈 on 1/28/25.
//  Copyright © 2024 이지훈. All rights reserved.
//

// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FlexSheet",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FlexSheet",
            targets: ["FlexSheet"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FlexSheet"),
        .testTarget(
            name: "FlexSheetTests",
            dependencies: ["FlexSheet"]
        ),
    ]
)
