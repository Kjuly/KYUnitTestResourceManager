//
//  KYUnitTestResourceManager_CacheTests.swift
//  KYUnitTestResourceManagerTests
//
//  Created by Kjuly on 9/1/2024.
//  Copyright © 2024 Kaijie Yu. All rights reserved.
//

import XCTest
@testable import KYUnitTestResourceManager

final class KYUnitTestResourceManager_CacheTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  // MARK: - Tests

  //
  // static KYUnitTestResourceManager.cacheFile(from:removeOld:)
  //
  func testCacheOneFile() async throws {
    let filename: String = KYUnitTestResourceFilename.image_png_01_small
    let localFileURL: URL = KYUnitTestResourceManager.localFileURL(with: filename)
    let cachedFileURL: URL = localFileURL.ky_toCachedFileForUnitTesting()

    let fileManager: FileManager = .default
    defer {
      try? fileManager.removeItem(at: localFileURL)
      try? KYUnitTestResourceManager.cleanAllCachedFiles()
    }

    // Make sure there are no local files before testing.
    try? fileManager.removeItem(at: localFileURL)

    //
    // File doesn't exist.
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL.path), false)
    // Cache file, do nothing.
    try KYUnitTestResourceManager.cacheFile(from: localFileURL)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL.path), false)

    //
    // Get testable file.
    _ = try await KYUnitTestResourceManager.getTestableFileURL(for: .image, with: filename)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL.path), true)
    // Cache file (use default value of `removeOld`).
    try KYUnitTestResourceManager.cacheFile(from: localFileURL)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL.path), false)

    //
    // Get testable file - 2nd time.
    _ = try await KYUnitTestResourceManager.getTestableFileURL(for: .image, with: filename)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL.path), true)
    // Cache file, but don't remove old file.
    try KYUnitTestResourceManager.cacheFile(from: localFileURL, removeOld: false)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL.path), true)

    //
    // Clean all cache, and cache the existing file directly.
    try KYUnitTestResourceManager.cleanAllCachedFiles()
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL.path), true)

    // Cache file and remove old file.
    try KYUnitTestResourceManager.cacheFile(from: localFileURL, removeOld: true)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL.path), false)
  }

  //
  // static KYUnitTestResourceManager.cacheFiles(from:removeOld:)
  //
  func testCacheMultipleFiles() async throws { // swiftlint:disable:this function_body_length
    let filename_01: String = KYUnitTestResourceFilename.image_png_01_small
    let filename_02: String = KYUnitTestResourceFilename.image_png_01_medium
    let filename_03: String = KYUnitTestResourceFilename.image_jpg_02
    let localFileURL_01: URL = KYUnitTestResourceManager.localFileURL(with: filename_01)
    let localFileURL_02: URL = KYUnitTestResourceManager.localFileURL(with: filename_02)
    let localFileURL_03: URL = KYUnitTestResourceManager.localFileURL(with: filename_03)
    let cachedFileURL_01: URL = localFileURL_01.ky_toCachedFileForUnitTesting()
    let cachedFileURL_02: URL = localFileURL_02.ky_toCachedFileForUnitTesting()
    let cachedFileURL_03: URL = localFileURL_03.ky_toCachedFileForUnitTesting()

    let localFileURLs: [URL] = [localFileURL_01, localFileURL_02, localFileURL_03]

    let fileManager: FileManager = .default
    defer {
      try? fileManager.removeItem(at: localFileURL_01)
      try? fileManager.removeItem(at: localFileURL_02)
      try? fileManager.removeItem(at: localFileURL_03)
      try? KYUnitTestResourceManager.cleanAllCachedFiles()
    }

    // Make sure there are no local files before testing.
    try? fileManager.removeItem(at: localFileURL_01)
    try? fileManager.removeItem(at: localFileURL_02)
    try? fileManager.removeItem(at: localFileURL_03)

    //
    // File doesn't exist.
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_01.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_02.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_03.path), false)
    // Cache file, do nothing.
    try KYUnitTestResourceManager.cacheFiles(from: localFileURLs)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_01.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_02.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_03.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_01.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_02.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_03.path), false)

    //
    // Get testable file.
    _ = try await KYUnitTestResourceManager.getTestableFileURL(for: .image, with: filename_01)
    _ = try await KYUnitTestResourceManager.getTestableFileURL(for: .image, with: filename_02)
    _ = try await KYUnitTestResourceManager.getTestableFileURL(for: .image, with: filename_03)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_01.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_02.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_03.path), true)
    // Cache file (use default value of `removeOld`).
    try KYUnitTestResourceManager.cacheFiles(from: localFileURLs)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_01.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_02.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_03.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_01.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_02.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_03.path), false)

    //
    // Get testable file - 2nd time.
    _ = try await KYUnitTestResourceManager.getTestableFileURL(for: .image, with: filename_01)
    _ = try await KYUnitTestResourceManager.getTestableFileURL(for: .image, with: filename_02)
    _ = try await KYUnitTestResourceManager.getTestableFileURL(for: .image, with: filename_03)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_01.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_02.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_03.path), true)
    // Cache file, but don't remove old file.
    try KYUnitTestResourceManager.cacheFiles(from: localFileURLs, removeOld: false)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_01.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_02.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_03.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_01.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_02.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_03.path), true)

    //
    // Clean all cache, and cache the existing file directly.
    try KYUnitTestResourceManager.cleanAllCachedFiles()
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_01.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_02.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_03.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_01.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_02.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_03.path), true)

    // Cache file and remove old file.
    try KYUnitTestResourceManager.cacheFiles(from: localFileURLs, removeOld: true)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_01.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_02.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_03.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_01.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_02.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_03.path), false)
  }

  //
  // static KYUnitTestResourceManager.cachedFilesAutomatically(removeOld:)
  //
  func testCacheFilesAutomatically() async throws { // swiftlint:disable:this function_body_length
    let filename_01: String = KYUnitTestResourceFilename.image_png_01_small
    let filename_02: String = KYUnitTestResourceFilename.image_png_01_medium
    let filename_03: String = KYUnitTestResourceFilename.image_jpg_02
    let localFileURL_01: URL = KYUnitTestResourceManager.localFileURL(with: filename_01)
    let localFileURL_02: URL = KYUnitTestResourceManager.localFileURL(with: filename_02)
    let localFileURL_03: URL = KYUnitTestResourceManager.localFileURL(with: filename_03)
    let cachedFileURL_01: URL = localFileURL_01.ky_toCachedFileForUnitTesting()
    let cachedFileURL_02: URL = localFileURL_02.ky_toCachedFileForUnitTesting()
    let cachedFileURL_03: URL = localFileURL_03.ky_toCachedFileForUnitTesting()

    let fileManager: FileManager = .default
    defer {
      try? fileManager.removeItem(at: localFileURL_01)
      try? fileManager.removeItem(at: localFileURL_02)
      try? fileManager.removeItem(at: localFileURL_03)
      try? KYUnitTestResourceManager.cleanAllCachedFiles()
    }

    // Make sure there are no local files before testing.
    try? fileManager.removeItem(at: localFileURL_01)
    try? fileManager.removeItem(at: localFileURL_02)
    try? fileManager.removeItem(at: localFileURL_03)

    //
    // File doesn't exist.
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_01.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_02.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_03.path), false)
    // Cache files automatically, do nothing.
    try KYUnitTestResourceManager.cacheFilesAutomatically()
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_01.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_02.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_03.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_01.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_02.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_03.path), false)

    //
    // Get testable file.
    _ = try await KYUnitTestResourceManager.getTestableFileURL(for: .image, with: filename_01)
    _ = try await KYUnitTestResourceManager.getTestableFileURL(for: .image, with: filename_02)
    _ = try await KYUnitTestResourceManager.getTestableFileURL(for: .image, with: filename_03)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_01.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_02.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_03.path), true)
    // Cache file (use default value of `removeOld`).
    try KYUnitTestResourceManager.cacheFilesAutomatically()
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_01.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_02.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_03.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_01.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_02.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_03.path), false)

    //
    // Get testable file - 2nd time.
    _ = try await KYUnitTestResourceManager.getTestableFileURL(for: .image, with: filename_01)
    _ = try await KYUnitTestResourceManager.getTestableFileURL(for: .image, with: filename_02)
    _ = try await KYUnitTestResourceManager.getTestableFileURL(for: .image, with: filename_03)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_01.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_02.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_03.path), true)
    // Cache file, but don't remove old file.
    try KYUnitTestResourceManager.cacheFilesAutomatically(removeOld: false)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_01.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_02.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_03.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_01.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_02.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_03.path), true)

    //
    // Clean all cache, and cache the existing file directly.
    try KYUnitTestResourceManager.cleanAllCachedFiles()
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_01.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_02.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_03.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_01.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_02.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_03.path), true)

    // Cache file and remove old file.
    try KYUnitTestResourceManager.cacheFilesAutomatically(removeOld: true)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_01.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_02.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: cachedFileURL_03.path), true)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_01.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_02.path), false)
    XCTAssertEqual(fileManager.fileExists(atPath: localFileURL_03.path), false)
  }

  // MARK: - Tests - Deletion

  //
  // static KYUnitTestResourceManager.cleanAllCachedFiles()
  //
  func testCleanAllCachedFiles() throws {
    let cacheCenterFolderURL: URL = KYUnitTestResourceManager.cacheCenterBaseURL
    let fileManager: FileManager = .default
    try? fileManager.removeItem(at: cacheCenterFolderURL)

    try FileManager.default.createDirectory(at: cacheCenterFolderURL, withIntermediateDirectories: true)
    XCTAssertEqual(fileManager.fileExists(atPath: cacheCenterFolderURL.path), true)

    try KYUnitTestResourceManager.cleanAllCachedFiles()
    XCTAssertEqual(fileManager.fileExists(atPath: cacheCenterFolderURL.path), false)
  }
}
