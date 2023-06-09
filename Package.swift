// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Logger",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "Logger",
            targets: ["Logger"])
    ],
    dependencies: [
      .package(url: "https://github.com/eonist/FileSugar.git", branch: "master")
    ],
    targets: [
        .target(
            name: "Logger",
            dependencies: ["FileSugar"]),
        .testTarget(
            name: "LoggerTests",
            dependencies: ["Logger"])
    ]
)
