//
//  String + EXT.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-10.
//

import SwiftUI

extension String {
    /// Prints the string directly to the console output.
    ///
    /// Use this for simple debug output without additional context such as file name or line number.
    ///
    /// Example:
    /// ```swift
    /// "Debug message".debugPrint()
    /// ```
    func debugPrint() {
        print(self)
    }
    
    /// Logs the string using the `Utilities.log` method.
    ///
    /// Includes file name, line number, and function name when in debug mode.
    ///
    /// Example:
    /// ```swift
    /// "User location updated".debugLog()
    /// ```
    func debugLog() {
        Utilities.log(self)
    }
}
