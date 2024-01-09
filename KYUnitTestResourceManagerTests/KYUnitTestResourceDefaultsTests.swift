//
//  KYUnitTestResourceDefaultsTests.swift
//  KYUnitTestResourceManagerTests
//
//  Created by Kjuly on 9/1/2024.
//  Copyright © 2024 Kaijie Yu. All rights reserved.
//

import XCTest
@testable import KYUnitTestResourceManager

final class KYUnitTestResourceDefaultsTests: XCTestCase {

  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  // MARK: - Tests - Resource Type

  //
  // enum KYUnitTestResourceType
  //
  func testKYUnitTestResourceType() throws {
    XCTAssertEqual(KYUnitTestResourceType.image.folderName, "images")
    XCTAssertEqual(KYUnitTestResourceType.video.folderName, "videos")
    XCTAssertEqual(KYUnitTestResourceType.audio.folderName, "audios")
  }

  // MARK: - Tests - Resource Filename

  //
  // enum KYUnitTestResourceFilename
  //
  func testExample() throws {
    //
    // Image
    // - JPG
    XCTAssertEqual(KYUnitTestResourceFilename.image_jpg_02, "image-02.jpg")
    XCTAssertEqual(KYUnitTestResourceFilename.image_jpg_03, "image-03.jpg")

    // - PNG
    XCTAssertEqual(KYUnitTestResourceFilename.image_png_01_medium, "image-01-medium.png")
    XCTAssertEqual(KYUnitTestResourceFilename.image_png_01_small, "image-01-small.png")

    // - GIF
    XCTAssertEqual(KYUnitTestResourceFilename.image_gif_01, "animated-image-01.gif")

    //
    // Video
    // - MOV
    XCTAssertEqual(KYUnitTestResourceFilename.video_mov_01_low, "video-01-low.mov")

    // - MP4
    XCTAssertEqual(KYUnitTestResourceFilename.video_mp4_02_low, "video-02-low.mp4")

    //
    // Audio
    // - MP3
    XCTAssertEqual(KYUnitTestResourceFilename.audio_mp3_01, "audio-01.mp3")
  }

  //
  // static KYUnitTestResourceFilename.allFilenames()
  //
  func testAllFilenamesOfKYUnitTestResourceFilename() throws {
    XCTAssertEqual(KYUnitTestResourceFilename.allFilenames(), [
      KYUnitTestResourceFilename.image_jpg_02,
      KYUnitTestResourceFilename.image_jpg_03,
      KYUnitTestResourceFilename.image_png_01_medium,
      KYUnitTestResourceFilename.image_png_01_small,
      KYUnitTestResourceFilename.image_gif_01,
      KYUnitTestResourceFilename.video_mov_01_low,
      KYUnitTestResourceFilename.video_mp4_02_low,
      KYUnitTestResourceFilename.audio_mp3_01,
    ])
  }
}
