//
//  KYUnitTestResourceManager+Cache.swift
//  KYUnitTestResourceManager
//
//  Created by Kjuly on 9/1/2024.
//  Copyright © 2024 Kaijie Yu. All rights reserved.
//

import Foundation

extension KYUnitTestResourceManager {

  static func createCacheCenterFolderIfNeeded() throws {
    if FileManager.default.fileExists(atPath: self.cacheCenterBaseURL.path) {
      return
    }
    try FileManager.default.createDirectory(at: self.cacheCenterBaseURL, withIntermediateDirectories: true)
  }

  /// Cache a downloaded file for use by other tests.
  ///
  /// If a cache file exists, the download process will first try to copy it to save unit testing time.
  ///
  /// - Parameters:
  ///   - localFileURL: The URL of the downloaded local file.
  ///   - removeOld: Whether to delete old local files after caching, default: true.
  ///
  public static func cacheFile(from localFileURL: URL, removeOld: Bool = true) throws {
    try createCacheCenterFolderIfNeeded()
    return try _cacheFile(from: localFileURL, removeOld: removeOld)
  }

  /// Cache some files for use by other tests.
  ///
  /// If a cache file exists, the download process will first try to copy it to save unit testing time.
  ///
  /// - Parameters:
  ///   - localFileURLs: An array of the downloaded local file URL.
  ///   - removeOld: Whether to delete old local files after caching, default: true.
  ///
  /// - Returns: The cached file URL.
  ///
  public static func cacheFiles(from localFileURLs: [URL], removeOld: Bool = true) throws {
    try createCacheCenterFolderIfNeeded()

    for url in localFileURLs {
      try _cacheFile(from: url, removeOld: removeOld)
    }
  }

  /// Automatically cache unit test resource files.
  ///
  /// - Parameter removeOld: Whether to delete old local files after caching, default: true.
  ///
  public static func cacheFilesAutomatically(removeOld: Bool = true) throws {
    try createCacheCenterFolderIfNeeded()

    for filename in autoCacheFilenames {
      try _cacheFile(from: localFileURL(with: filename), removeOld: removeOld)
    }
  }

  private static func _cacheFile(from localFileURL: URL, removeOld: Bool) throws {
    _log("Start caching file: \(localFileURL.lastPathComponent).")
    let fileManager: FileManager = .default

    // Cache the file only if it exists.
    guard fileManager.fileExists(atPath: localFileURL.path) else {
      _log("- Skip cache because the file does not exist.")
      return
    }

    let cachedFileURL: URL = localFileURL.ky_toCachedFileForUnitTesting()

    // Cache resource file only if the same cache does not exist.
    if fileManager.fileExists(atPath: cachedFileURL.path) {
      _log("- Skip cache because the same file is already cached.")
    } else {
      try fileManager.copyItem(at: localFileURL, to: cachedFileURL)
      _log("- Cached file.")
    }

    // Delete old files if necessary.
    if removeOld {
      try fileManager.removeItem(at: localFileURL)
      _log("- Removed old file.")
    }
  }

  // MARK: - Deletion

  /// Clean all cached files.
  public static func cleanAllCachedFiles() throws {
    try FileManager.default.removeItem(at: self.cacheCenterBaseURL)
    _log("Cleaned all cached files at \(self.cacheCenterBaseURL)")
  }
}
