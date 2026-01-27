// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Blast",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "Blast", targets: ["Blast"])
    ],
    targets: [
        .target(
            name: "Blast",
            path: "Blast"
        )
    ]
)
