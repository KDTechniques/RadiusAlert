//
//  View+EXT.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

extension View {
    /// Applies a set of modifiers for SwiftUI previews to ensure
    /// consistency in testing environments.
    ///
    /// - Returns: A modified view with light color scheme and injected dependencies.
    func previewModifier() ->  some View {
        self
            .preferredColorScheme(.light)
            .environment(MapViewModel(settingsVM: .init()))
            .environment(SettingsViewModel())
    }
    
    /// Attaches an alert that displays based on a bound `AlertModel?`.
    ///
    /// - Parameter item: A `Binding` to an optional `AlertModel`.
    ///   When non-nil, the alert is presented.
    ///
    /// - Returns: A modified view with the alert attached.
    ///
    /// This helper also triggers haptic feedback (if specified in the model).
    func alertViewModifier(item: Binding<AlertModel?>) -> some View {
        self
            .alert(item: item) { alertItem in
                // Trigger haptic feedback asynchronously
                Task {
                    await HapticManager.shared.vibrate(type: alertItem.hapticType)
                }
                
                if let secondaryAction: Alert.Button = alertItem.secondaryAction {
                    return Alert(
                        title: Text(alertItem.title),
                        message: Text(alertItem.message),
                        primaryButton: alertItem.primaryAction,
                        secondaryButton: secondaryAction
                    )
                } else {
                    return Alert(
                        title: Text(alertItem.title),
                        message: Text(alertItem.message),
                        dismissButton: alertItem.primaryAction
                    )
                }
            }
    }
}
