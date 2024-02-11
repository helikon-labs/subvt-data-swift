// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SubVTData",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
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
            .upToNextMinor(from: "5.8.1")
        ),
        .package(
            url: "https://github.com/konkab/AlamofireNetworkActivityLogger.git",
            .upToNextMinor(from: "3.4.0")
        ),
        .package(
            name: "Base58Swift",
            url: "https://github.com/keefertaylor/Base58Swift.git",
            .upToNextMinor(from: "2.1.7")
        ),
        .package(
            url: "https://github.com/attaswift/BigInt.git",
            .upToNextMinor(from: "5.3.0")
        ),
        .package(
            name: "Blake2",
            url: "https://github.com/tesseract-one/Blake2.swift.git",
            .upToNextMinor(from: "0.2.0")
        ),
        .package(
            url: "https://github.com/kishikawakatsumi/KeychainAccess.git",
            .upToNextMinor(from: "4.2.2")
        ),
        .package(
            name: "secp256k1",
            url: "https://github.com/GigaBitcoin/secp256k1.swift.git",
            .upToNextMinor(from: "0.15.0")
        ),
        .package(
            url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git",
            .upToNextMajor(from: "2.0.0")
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
                "Base58Swift",
                "Blake2",
                "BigInt",
                "KeychainAccess",
                "secp256k1",
                "SwiftyBeaver"
            ],
            resources: [
                .copy("Resources/data-env.json"),
                .copy("Resources/data-env-example.json"),
            ]
        ),
        .testTarget(
            name: "SubVTDataTests",
            dependencies: ["SubVTData"]
        ),
    ]
)
