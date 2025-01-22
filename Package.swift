// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "starwarsui",
    platforms: [.macOS(.v13), .iOS(.v13)],
    products: [
        .library(name: "SWUI", targets: ["SWUI"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-openapi-generator", from: "1.6.0"),
        .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.7.0"),
        .package(url: "https://github.com/apple/swift-openapi-urlsession", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "SWUI",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession")
            ],
            swiftSettings: [
                .define("PUBLIC_TYPES")
            ]
        )
    ]
)
