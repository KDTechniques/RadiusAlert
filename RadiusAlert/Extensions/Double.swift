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
    
    /// Rounds the current `Double` value to the specified number of decimal places
    /// and returns it as a `String`.
    /// - Parameter places: The number of decimal places to round to.
    /// - Returns: A string representation of the rounded value.
    ///
    /// Example:
    /// ```swift
    /// let value: Double = 3.14159
    /// let roundedValue = value.rounded(to: 2) // "3.14"
    /// ```
    func rounded(to places: Int) -> String {
        return .init(format: "%.\(places)f", self)
    }
}
