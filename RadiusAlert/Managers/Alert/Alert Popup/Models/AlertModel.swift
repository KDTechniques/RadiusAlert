//
//  AlertModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-05.
//

import SwiftUI

/// A model representing an alert in the app.
///
/// Each `AlertModel` has a unique identifier, a title, an optional message,
/// a haptic feedback type, and one or more associated alert buttons.
///
/// Example usage:
/// ```swift
/// let alert = AlertModel(
///     title: "Network Error",
///     message: "Please try again later.",
///     hapticType: .error,
///     actions: [
///         AlertButtonModel(role: .ok),
///         AlertButtonModel(role: .cancel)
///     ]
/// )
/// ```
struct AlertModel: Identifiable {
    let id: String = UUID().uuidString
    let viewLevel: AlertViewLevels
    let title: String
    let message: String
    let hapticType: HapticTypes
    let actions: [AlertButtonModel]
    
    init(
        viewLevel: AlertViewLevels,
        title: String,
        message: String = "",
        hapticType: HapticTypes,
        actions: [AlertButtonModel],
    ) {
        self.viewLevel = viewLevel
        self.title = title
        self.message = message
        self.hapticType = hapticType
        self.actions = actions
    }
}
