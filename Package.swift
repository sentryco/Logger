// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Logger", // Name of the package
    platforms: [.iOS(.v17), .macOS(.v14)], // Platforms the package supports
    products: [
        .library(
            name: "Logger", // Name of the library
            targets: ["Logger"]) // Targets that are part of the library
    ],
    dependencies: [
//      .package(url: "https://github.com/eonist/FileSugar.git", branch: "master") // Dependencies of the package
    ],
    targets: [
        .target(
            name: "Logger", // Name of the target
            dependencies: [/*"FileSugar"*/]), // Dependencies of the target
        .testTarget(
            name: "LoggerTests", // Name of the test target
            dependencies: ["Logger"]) // Dependencies of the test target
    ]
)
