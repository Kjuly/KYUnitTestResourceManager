//
//  KYUnitTestResourceManager_DownloadTests.swift
//  KYUnitTestResourceManagerTests
//
//  Created by Kjuly on 9/1/2024.
//  Copyright © 2024 Kaijie Yu. All rights reserved.
//

import XCTest
@testable import KYUnitTestResourceManager

final class KYUnitTestResourceManager_DownloadTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  // MARK: - Tests

  //
  // static KYUnitTestResourceManager.getTestableFileURL(for:with:downloadIfUnavailable:)
  //
  func testGetTestableFileURL() async throws {
    let filename: String = KYUnitTestResourceFilename.image_png_01_small
    let localFileURL: URL = KYUnitTestResourceManager.localFileURL(with: filename)
    let fileManager: FileManager = .default
    defer {
      try? fileManager.removeItem(at: localFileURL)
      try? KYUnitTestResourceManager.cleanAllCachedFiles()
    }

    // Make sure there are no local files before testing.
    try? fileManager.removeItem(at: localFileURL)

    // File doesn't exist.
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL.path), false)

    var testableFileURL: URL?

    //
    // Get testable file - 1st time.
    // > The file does not exist and is not cached. Do nothing because of `downloadIfUnavailable=false`.
    testableFileURL = try await KYUnitTestResourceManager.getTestableFileURL(for: .image, with: filename, downloadIfUnavailable: false)
    XCTAssertEqual(testableFileURL, nil)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL.path), false)

    //
    // Get testable file - 2nd time.
    // > The file does not exist and is not cached. It will be downloaded remotely.
    testableFileURL = try await KYUnitTestResourceManager.getTestableFileURL(for: .image, with: filename)
    XCTAssertEqual(testableFileURL, localFileURL)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL.path), true)

    // Cache and then remove the file.
    try KYUnitTestResourceManager.cacheFile(from: localFileURL)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL.path), false)

    //
    // Get testable file - 3rd time.
    // > The file does not exist but the cache exists, the cache file will be copied.
    testableFileURL = try await KYUnitTestResourceManager.getTestableFileURL(for: .image, with: filename)
    XCTAssertEqual(testableFileURL, localFileURL)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL.path), true)

    //
    // Get testable file - 4th time.
    // > The file already exists, use it directly.
    testableFileURL = try await KYUnitTestResourceManager.getTestableFileURL(for: .image, with: filename)
    XCTAssertEqual(testableFileURL, localFileURL)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL.path), true)
  }

  //
  // static KYUnitTestResourceManager.downloadFile(from:to:)
  //
  func testDownloadFile() async throws {
    let filename: String = KYUnitTestResourceFilename.image_png_01_small
    let localFileURL: URL = KYUnitTestResourceManager.localFileURL(with: filename)
    let fileManager: FileManager = .default
    defer {
      try? fileManager.removeItem(at: localFileURL)
    }

    // Make sure there are no local files before testing.
    try? fileManager.removeItem(at: localFileURL)

    // File doesn't exist.
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL.path), false)

    // Download file.
    try await KYUnitTestResourceManager.downloadFile(
      from: KYUnitTestResourceManager.remoteFileURL(for: .image, with: filename)!,
      to: localFileURL)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL.path), true)
  }
}
