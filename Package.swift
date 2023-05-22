// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ia_algorithms_swift",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(
            name: "ia_algorithms_swift",
            path: "Sources",
            resources: [
                .process("Resources")
            ],
            linkerSettings: [LinkerSetting.linkedFramework("CreateML")]
        )
    ]
)
