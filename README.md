<p align="center">
    <img width="400" src="https://raw.githubusercontent.com/helikon-labs/subvt/main/assets/design/logo/subvt_logo_blue.png">
</p>

![](https://github.com/helikon-labs/subvt-data-ios/actions/workflows/swift_build_and_test.yml/badge.svg)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=helikon-labs_subvt-data-ios&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=helikon-labs_subvt-data-ios)

# SubVT Data Access for Swift

SubVT (Substrate Validator Toolkit) data access library for Swift.

Please visit the [top-level Subvt repository](https://github.com/helikon-labs/subvt) for project information.

## Build & Test

- Rename the file `Sources/SubVTData/Resources/env-example.json` to `env.json`, and edit the file contents with the service host and port details.
- Run `swift test` in the root folder to test.
- Run `swift build` in the root folder to build.

## Installation

### Swift Package Manager

```swift
let package = Package(
    // ...
    dependencies: [
        // ...
        .package(
            url: "https://github.com/helikon-labs/subvt-data-ios.git",
            .upToNextMinor(from: "0.2.1")
        )
    ],
    targets: [
        .target(
            name = "YourTarget",
            dependencies: [
                // ...
                .product(name: "SubVTData", package: "subvt-data-ios"),
                // ...
            ],
            // ...
        )
    ]
)
```
## Usage

Please refer to the [tests](./Tests/SubVTDataTests) for information about how to use the report and application REST services, and network status, active/inactive validator list and validator details RPC pub/sub services.
