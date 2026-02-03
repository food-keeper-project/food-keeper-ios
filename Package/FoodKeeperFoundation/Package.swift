// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FoodKeeperFoundation",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FoodKeeperFoundation",
            targets: ["FoodKeeperFoundation"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/SnapKit/SnapKit",
            exact: "5.7.1"
        ),
        .package(
            url: "https://github.com/Moya/Moya",
            .upToNextMajor(
                from: "15.0.3"
            )
        ),
        .package(
            url: "https://github.com/ReactiveX/RxSwift",
            .upToNextMajor(
                from: "6.9.1"
            )
        ),
        .package(
            url: "https://github.com/onevcat/Kingfisher",
            exact: "8.6.2"
        ),
    ],
    targets: [
        .target(
            name: "FoodKeeperFoundation",
            dependencies: [
                "Moya",
                .product(name: "RxCocoa", package: "RxSwift"),
                "SnapKit",
                "Kingfisher",
            ],
            resources: [
                .process("Resources")
            ]
        ),
    ]
)
