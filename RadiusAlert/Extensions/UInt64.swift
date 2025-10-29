//
//  UInt64.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-08.
//

import Foundation

extension UInt64 {
    /// Converts a duration in seconds (as a `Double`) into nanoseconds (`UInt64`).
    ///
    /// This is useful when working with APIs like `Task.sleep`, which require
    /// time values in `UInt64` nanoseconds, while allowing you to declare and
    /// use durations as `Double` values for readability.
    ///
    /// - Parameter value: The duration in seconds.
    /// - Returns: The duration in nanoseconds, represented as `UInt64`.
    ///
    /// Example:
    /// ```swift
    /// try await Task.sleep(nanoseconds: .seconds(1.5))
    /// // Sleeps for 1.5 seconds
    /// ```
    static func seconds(_ value: Double) -> Self {
        return Self(value * 1_000_000_000)
    }
}
