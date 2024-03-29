// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "CPFListController",
    products: [
        .library(
            name: "CPFListController",
            targets: ["CPFListController"]),
        .library(
            name: "CPFListController-Dynamic",
            type: .dynamic,
            targets: ["CPFListController"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Loadar/CPFChain.git", from: Version(stringLiteral: "2.2.5")),
    ],
    targets: [
        .target(
            name: "CPFListController-Foundation",
            dependencies: [],
            path: "Sources/CPFListController/Foundation",
            resources: [.copy("../../PrivacyInfo.xcprivacy")]
        ),
        .target(
            name: "CPFListController",
            dependencies: ["CPFChain", "CPFListController-Foundation"],
            path: "Sources/CPFListController/Interface",
            resources: [.copy("../../PrivacyInfo.xcprivacy")]
        ),
    ]
)
