//
//  Color+EXT.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-04.
//

import SwiftUI

extension Color {
    /// Generates a random color for debugging purposes.
    ///
    /// - Returns: A `Color` instance with random red, green, and blue values.
    ///
    /// Example:
    /// ```swift
    /// Rectangle().fill(.debug)
    /// ```
    static var debug: Self {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        
        return Color(red: red, green: green, blue: blue)
    }
    
    /// Returns a color that contrasts with the current primary color
    /// depending on the system's color scheme.
    ///
    /// - Parameter colorScheme: The current `ColorScheme` (light or dark).
    /// - Returns: `.white` in dark mode, `.black` in light mode.
    static func getNotPrimary(colorScheme: ColorScheme) -> Self {
        return colorScheme == .dark ? .white : .black
    }
}
