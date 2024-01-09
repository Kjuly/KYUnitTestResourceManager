//
//  KYUnitTestResourceManagerErrorTests.swift
//  KYUnitTestResourceManagerTests
//
//  Created by Kjuly on 9/1/2024.
//  Copyright © 2024 Kaijie Yu. All rights reserved.
//

import XCTest
@testable import KYUnitTestResourceManager

final class KYUnitTestResourceManagerErrorTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  //
  // KYUnitTestResourceManagerError.getter:errorDescription
  //
  func testErrorDescription() throws {
    XCTAssertEqual(KYUnitTestResourceManagerError.failedToCreateRemoteURL("abc").errorDescription,
                   "Failed to create URL with filename: abc.")
    XCTAssertEqual(KYUnitTestResourceManagerError.others("An error msg.").errorDescription,
                   "An error msg.")
  }
}
