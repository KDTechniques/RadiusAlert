//
//  Color.swift
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
    /// - Returns: `.black` in dark mode, `.white` in light mode.
    static func getNotPrimary(colorScheme: ColorScheme) -> Self {
        return colorScheme == .dark ? .black : .white
    }
    
    /// Provides access to all centralized custom colors defined in `CustomColors`.
    ///
    /// This allows referencing custom colors directly from `Color.custom`,
    /// making the code more readable and consistent.
    ///
    /// Example:
    /// ```swift
    /// let background = Color.custom.SearchBar.searchBarBackground.color
    /// let mapButton = Color.custom.Map.mapControlButtonBackground.color
    /// ```
    static let custom: CustomColors.Type = CustomColors.self
}
