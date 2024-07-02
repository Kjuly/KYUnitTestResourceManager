//
//  URL+KYUnitTestResourceManager.swift
//  KYUnitTestResourceManager
//
//  Created by Kjuly on 9/1/2024.
//  Copyright © 2024 Kaijie Yu. All rights reserved.
//

import Foundation

extension URL {

  /// Check whether the local file exists or not.
  func ky_localFileExists() -> Bool {
    return FileManager.default.fileExists(atPath: self.path)
  }

  /// Convert to cached file URL.
  func ky_toCachedFileForUnitTesting() -> URL {
    return KYUnitTestResourceManager.cacheCenterBaseURL.appendingPathComponent(self.lastPathComponent)
  }
}
