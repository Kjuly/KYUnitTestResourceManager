//
//  KYUnitTestResourceManagerTests.swift
//  KYUnitTestResourceManagerTests
//
//  Created by Kjuly on 9/1/2024.
//  Copyright © 2024 Kaijie Yu. All rights reserved.
//

import XCTest
@testable import KYUnitTestResourceManager

final class KYUnitTestResourceManagerTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  // MARK: - Tests - Property

  func testExample() throws {
    XCTAssertEqual(KYUnitTestResourceManager.remoteBaseURL,
                   URL(string: "https://raw.githubusercontent.com/Kjuly/unit-test-resources/main"))
    XCTAssertEqual(KYUnitTestResourceManager.localBaseURL,
                   FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])

    XCTAssertEqual(KYUnitTestResourceManager.cacheCenterFolderName, "ky_unit_test_resources_cache")
    XCTAssertEqual(KYUnitTestResourceManager.cacheCenterBaseURL,
                   FileManager.default.urls(
                    for: .documentDirectory,
                    in: .userDomainMask
                   )[0].appendingPathComponent("ky_unit_test_resources_cache"))

    XCTAssertEqual(KYUnitTestResourceManager.autoCacheFilenames, KYUnitTestResourceFilename.allFilenames())
  }

  // MARK: - Tests

  //
  // static KYUnitTestResourceManager.localFileURL(with:)
  //
  func testLocalFileURL() throws {
    XCTAssertEqual(KYUnitTestResourceManager.localFileURL(with: "abc"),
                   KYUnitTestResourceManager.localBaseURL.appendingPathComponent("abc"))
  }

  //
  // static KYUnitTestResourceManager.remoteFileURL(for:with:)
  //
  func testRemoteFileURL() throws {
    let baseURL = URL(string: "https://raw.githubusercontent.com/Kjuly/unit-test-resources/main")
    XCTAssertEqual(KYUnitTestResourceManager.remoteFileURL(for: .image, with: "abc.jpg"),
                   baseURL?.appendingPathComponent("images/abc.jpg"))
    XCTAssertEqual(KYUnitTestResourceManager.remoteFileURL(for: .video, with: "abc.mp4"),
                   baseURL?.appendingPathComponent("videos/abc.mp4"))
    XCTAssertEqual(KYUnitTestResourceManager.remoteFileURL(for: .audio, with: "abc.mp3"),
                   baseURL?.appendingPathComponent("audios/abc.mp3"))
  }
}
