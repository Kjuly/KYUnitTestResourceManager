//
//  KYUnitTestResourceManager.swift
//  KYUnitTestResourceManager
//
//  Created by Kjuly on 9/1/2024.
//  Copyright © 2024 Kaijie Yu. All rights reserved.
//

import Foundation

public struct KYUnitTestResourceManager {

  public static let remoteBaseURL: URL = URL(string: "https://raw.githubusercontent.com/Kjuly/unit-test-resources/main")!
  public static let localBaseURL: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

  public static let cacheCenterFolderName = "ky_unit_test_resources_cache"
  public static let cacheCenterBaseURL: URL = localBaseURL.appendingPathComponent(cacheCenterFolderName)

  public static let autoCacheFilenames: [String] = KYUnitTestResourceFilename.allFilenames()

  // MARK: - File URL

  /// Get a local file URL with a filename.
  public static func localFileURL(with filename: String) -> URL {
    return Self.localBaseURL.appendingPathComponent(filename)
  }

  /// Get a remote file URL for a resource type with filename.
  ///
  /// - Parameters:
  ///   - type: Resource type, refer to KYUnitTestResourceType.
  ///   - filename: A filename with extension.
  ///
  /// - Returns: A remote file URL, nil if invalid.
  ///
  public static func remoteFileURL(for type: KYUnitTestResourceType, with filename: String) -> URL? {
    return URL(string: type.folderName + "/" + filename, relativeTo: Self.remoteBaseURL)
  }
}
