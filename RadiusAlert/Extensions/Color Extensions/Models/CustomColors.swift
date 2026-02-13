//
//  CustomColors.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-16.
//

import SwiftUI

/// A centralized namespace for all custom colors used in the app.
///
/// System colors are excluded; only custom-defined colors from the asset catalog are included.
///
/// ### Reasoning
/// If colors are directly referenced in the UI using asset names (e.g., `.customColor1`),
/// renaming a color in the asset catalog can break references throughout the codebase.
/// This approach is not scalable or maintainable.
///
/// By centralizing all custom colors in a single value type,
/// you only need to update the reference here if an asset name changes,
/// ensuring consistency and reducing the risk of errors.
enum CustomColors {
    
    /// Custom colors related to the map UI components.
    enum Map: CustomColorsProtocol {
        case mapControlButtonBackground
        
        /// Returns the associated `Color` for each map-related case.
        ///
        /// Example:
        /// ```swift
        /// let background = CustomColors.Map.mapControlButtonBackgroundViewModifier.color
        /// ```
        var color: Color {
            switch self {
            case .mapControlButtonBackground:
                return .mapControlButtonBackground
            }
        }
    }
    
    /// Custom colors related to the search bar UI components.
    enum SearchBar: CustomColorsProtocol {
        case searchBarBackground
        case searchBarForeground
        
        /// Returns the associated `Color` for each search bar–related case.
        ///
        /// Example:
        /// ```swift
        /// let background = CustomColors.SearchBar.searchBarBackground.color
        /// let foreground = CustomColors.SearchBar.searchBarForeground.color
        /// ```
        var color: Color {
            switch self {
            case .searchBarBackground:
                return .searchBarBackground
            case .searchBarForeground:
                return .searchBarForeground
            }
        }
    }
}

protocol CustomColorsProtocol {
    var color: Color { get }
}
