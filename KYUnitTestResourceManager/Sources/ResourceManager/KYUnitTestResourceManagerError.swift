//
//  KYUnitTestResourceManagerError.swift
//  KYUnitTestResourceManager
//
//  Created by Kjuly on 9/1/2024.
//  Copyright © 2024 Kaijie Yu. All rights reserved.
//

import Foundation

public enum KYUnitTestResourceManagerError: Error {
  case failedToCreateRemoteURL(String)
  case others(String)
}

extension KYUnitTestResourceManagerError: Equatable {}

extension KYUnitTestResourceManagerError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .failedToCreateRemoteURL(let filename):
      return "Failed to create URL with filename: \(filename)."
    case .others(let errorMessage):
      return errorMessage
    }
  }
}
