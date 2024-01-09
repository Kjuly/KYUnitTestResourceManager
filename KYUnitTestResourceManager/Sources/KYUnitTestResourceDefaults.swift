//
//  KYUnitTestResourceDefaults.swift
//  KYUnitTestResourceManager
//
//  Created by Kjuly on 9/1/2024.
//  Copyright © 2024 Kaijie Yu. All rights reserved.
//

import Foundation

// MARK: - Resource Type

public enum KYUnitTestResourceType {
  case image
  case video
  case audio

  var folderName: String {
    switch self {
    case .image: return "images"
    case .video: return "videos"
    case .audio: return "audios"
    }
  }
}

// MARK: - Resource Filename

public enum KYUnitTestResourceFilename {
  //
  // Image
  // - JPG
  public static let image_jpg_02 = "image-02.jpg"
  public static let image_jpg_03 = "image-03.jpg"

  // - PNG
  public static let image_png_01_medium = "image-01-medium.png"
  public static let image_png_01_small = "image-01-small.png"

  // - GIF
  public static let image_gif_01 = "animated-image-01.gif"

  //
  // Video
  // - MOV
  public static let video_mov_01_low = "video-01-low.mov"

  // - MP4
  public static let video_mp4_02_low = "video-02-low.mp4"

  //
  // Audio
  // - MP3
  public static let audio_mp3_01 = "audio-01.mp3"

  /// Get all resource filenames.
  public static func allFilenames() -> [String] {
    return [
      image_jpg_02,
      image_jpg_03,
      image_png_01_medium,
      image_png_01_small,
      image_gif_01,
      video_mov_01_low,
      video_mp4_02_low,
      audio_mp3_01,
    ]
  }
}
