// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "CPFListController",
    products: [
        .library(
            name: "CPFListController",
            targets: ["CPFListController"]),
        .library(
            name: "CPFListControllerDynamic",
            type: .dynamic,
            targets: ["CPFListController"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Loadar/CPFChain.git", from: Version(stringLiteral: "2.2.6")),
    ],
    targets: [
        .target(
            name: "CPFListControllerFoundation",
            dependencies: [],
            path: "Sources/CPFListController/Foundation"
        ),
        .target(
            name: "CPFListController",
            dependencies: [
                .product(name: "CPFChainDynamic", package: "CPFChain"),
                "CPFListControllerFoundation"
            ],
            path: "Sources/CPFListController/Interface"
        ),
    ]
)
