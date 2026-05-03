//
//  Optional.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-03-03.
//

import Foundation

extension Optional {
    /// Returns a Boolean value indicating whether the optional is `nil`.
    /// Provides a cleaner alternative to comparing with `== nil`.
    ///
    /// Example:
    /// ```swift
    /// let value: Int? = nil
    /// let isNil = value.isNil() // true
    /// `
    func isNil() -> Bool {
        return self == nil
    }
}
