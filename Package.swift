// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "KYUnitTestResourceManager",
  platforms: [
    .iOS("15.5"),
    .watchOS(.v6),
    .macOS(.v12),
  ],
  products: [
    .library(
      name: "KYUnitTestResourceManager",
      targets: [
        "KYUnitTestResourceManager",
      ]),
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "KYUnitTestResourceManager",
      dependencies: [
      ],
      path: "KYUnitTestResourceManager/Sources"),
    .testTarget(
      name: "KYUnitTestResourceManagerTests",
      dependencies: [
        "KYUnitTestResourceManager",
      ],
      path: "KYUnitTestResourceManagerTests"),
  ]
)
