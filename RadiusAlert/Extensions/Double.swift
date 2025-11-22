//
//  Double.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-10-28.
//

import Foundation

extension Double {
    /// Converts the current `Double` value to an `Int`.
    /// - Returns: The integer representation of the double, truncating any fractional part.
    ///
    /// Example:
    /// ```swift
    /// let value: Double = 3.7
    /// let intValue = value.int() // intValue is 3
    /// ```
    func int() -> Int {
        return Int(self)
    }
    
    func rounded(to places: Int) -> String {
        return .init(format: "%.\(places)f", self)
    }
}
