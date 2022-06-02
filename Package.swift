// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SubVTData",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v5),
        .macOS(.v10_15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SubVTData",
            targets: ["SubVTData"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            .upToNextMajor(from: "5.0.0")
        ),
        .package(
            url: "https://github.com/konkab/AlamofireNetworkActivityLogger.git",
            .upToNextMajor(from: "3.4.0")
        ),
        .package(
            url: "https://github.com/attaswift/BigInt.git",
            .upToNextMajor(from: "5.3.0")
        ),
        .package(
            url: "https://github.com/kishikawakatsumi/KeychainAccess.git",
            .upToNextMajor(from: "4.0.0")
        ),
        .package(
            name: "secp256k1",
            url: "https://github.com/GigaBitcoin/secp256k1.swift.git",
            .upToNextMajor(from: "0.3.4")
        ),
        .package(
            url: "https://github.com/daltoniam/Starscream.git",
            .upToNextMajor(from: "4.0.0")
        ),
        .package(
            url: "https://github.com/apple/swift-log.git",
            .upToNextMajor(from: "1.0.0")
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SubVTData",
            dependencies: [
                "Alamofire",
                "AlamofireNetworkActivityLogger",
                "BigInt",
                "KeychainAccess",
                "secp256k1",
                "Starscream",
                .product(name: "Logging", package: "swift-log")
            ],
            exclude: [
                "Resources/env-example.json"
            ],
            resources: [
                .copy("Resources/env.json"),
            ]
        ),
        .testTarget(
            name: "SubVTDataTests",
            dependencies: ["SubVTData"]
        ),
    ]
)
