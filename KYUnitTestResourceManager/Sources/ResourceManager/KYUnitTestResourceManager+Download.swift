//
//  KYUnitTestResourceManager+Download.swift
//  KYUnitTestResourceManager
//
//  Created by Kjuly on 9/1/2024.
//  Copyright © 2024 Kaijie Yu. All rights reserved.
//

import Foundation

extension KYUnitTestResourceManager {

  /// Get the testable file URL and download the file if it does not exist locally.
  ///
  /// - 1. When the same file exists locally, it will be used directly;
  /// - 2. If a cache is available, will try to copy the file;
  /// - 3. If there is no cache, it will be downloaded from remote.
  ///
  /// - Parameters:
  ///   - type: Resource type, refer to KYUnitTestResourceType.
  ///   - filename: A filename with extension.
  ///   - downloadIfUnavailable: Whether the file needs to be downloaded when it does not exist, default: true.
  ///
  /// - Returns: A local file URL.
  ///
  public static func getTestableFileURL(
    for type: KYUnitTestResourceType,
    with filename: String,
    downloadIfUnavailable: Bool = true
  ) async throws -> URL? {

    // Check if the local file exists.
    let localFileURL: URL = localFileURL(with: filename)
    if localFileURL.ky_localFileExists() {
      _log("Use existing file \"\(filename)\"")
      return localFileURL
    }

    // Check if the cache file exists.
    let cachedFileURL: URL = localFileURL.ky_toCachedFileForUnitTesting()
    if FileManager.default.fileExists(atPath: cachedFileURL.path) {
      try FileManager.default.copyItem(at: cachedFileURL, to: localFileURL)
      _log("Use cached file \"\(filename)\"")
      return localFileURL
    }

    guard downloadIfUnavailable else {
      return nil
    }

    // Download file from remote.
    guard let remoteFileURL: URL = remoteFileURL(for: type, with: filename) else {
      throw KYUnitTestResourceManagerError.failedToCreateRemoteURL(filename)
    }
    try await downloadFile(from: remoteFileURL, to: localFileURL)
    return localFileURL
  }

  /// Download a file from remote to local.
  ///
  /// - Parameters:
  ///   - remoteFileURL: A remote file URL based on `remoteBaseURL`.
  ///   - localFileURL: A local file URL based on `localBaseURL`.
  ///
  public static func downloadFile(from remoteFileURL: URL, to localFileURL: URL) async throws {
    let (tmpURL, _) = try await URLSession.shared.download(from: remoteFileURL)
    try FileManager.default.copyItem(at: tmpURL, to: localFileURL)
    _log("Downloaded file \"\(remoteFileURL.lastPathComponent)\" at \(localFileURL.path)")
  }
}
