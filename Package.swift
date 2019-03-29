// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "modifier-remover",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(
            name: "modifier-remover",
            targets: ["modifier-remover"]),
        
        ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", .exact("0.50000.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "modifier-remover",
            dependencies: ["modifier-remover-core"],
            path: "Sources/modifier-remover/tool"),
        .target(
            name: "modifier-remover-core",
            dependencies: ["SwiftSyntax"],
            path: "Sources/modifier-remover/core"),
        .testTarget(
            name: "modifier-removerTests",
            dependencies: ["modifier-remover-core"]),
    ]
)
