//
//  KYUnitTestResourceManager+Log.swift
//  KYUnitTestResourceManager
//
//  Created by Kjuly on 9/1/2024.
//  Copyright © 2024 Kaijie Yu. All rights reserved.
//

import Foundation

extension KYUnitTestResourceManager {

  static func _log(
    _ message: String,
    function: String = #function,
    file: String = #file,
    line: Int = #line
  ) {
    let fileString: NSString = NSString(string: file)
    print("♻️ -[\(fileString.lastPathComponent) \(function)] L\(line): \(message)")
  }
}
