//
//  Array+EXT.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-08-03.
//

import Foundation

extension Array {
    /// Returns the next valid index in the array after the given index.
    ///
    /// - Parameter givenIndex: The current index to calculate the next index from.
    /// - Returns: The next index if available, otherwise wraps around and returns `0`.
    ///
    /// Example:
    /// ```swift
    /// let numbers = [10, 20, 30]
    /// numbers.nextIndex(after: 1) // returns 2
    /// numbers.nextIndex(after: 2) // wraps around and returns 0
    /// ```
    func nextIndex(after givenIndex: Int) -> Int {
        let lastIndex: Int = self.count-1
        return givenIndex < lastIndex ? givenIndex+1 : 0
    }
}
