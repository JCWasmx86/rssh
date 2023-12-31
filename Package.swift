// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "rssh",
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url: "https://github.com/jakeheis/Shout", from: "0.5.7"),
    .package(url: "https://github.com/kylef/PathKit", from: "1.0.1"),
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.
    .systemLibrary(name: "rl", pkgConfig: "readline"),
    .executableTarget(
      name: "rssh",
      dependencies: [
        "Shout", "rl", "PathKit",
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ]
    ), .testTarget(name: "rsshTests", dependencies: ["rssh"]),
  ]
)
