//
//  View.swift
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
            .environment(AboutViewModel())
            .environment(SavedPinsViewModel())
            .dynamicTypeSizeViewModifier
    }
    
    /// A global alert view modifier attached to the `ContentView`.
    /// Handles and presents all alert popups managed by `AlertManager`
    /// throughout the entire app lifecycle.
    @ViewBuilder
    var alertViewModifier: some View {
        let alertManager: AlertManager = .shared
        let firstItem: AlertModel? = alertManager.getFirstAlertItem()
        
        self
            .alert(
                firstItem?.title ?? "",
                /// isPresented: get true & false, but only setting false when dismissed by the user.
                isPresented: alertManager.alertPopupBinding(),
                presenting: firstItem,
                actions: { alert in
                    ForEach(alert.actions) { action in
                        action.button
                    }
                },
                message: { alert in
                    Text(alert.message)
                }
            )
    }
    
    /// Restricts the dynamic type size of the view to a range between `.xSmall` and `.large`.
    ///
    /// This ensures that the text inside the view will scale only within this range,
    /// while still respecting accessibility settings up to the **default iPhone text size** (`.large`).
    ///
    /// Example:
    /// ```swift
    /// Text("Hello, world!")
    ///     .dynamicTypeSizeViewModifier
    /// ```
    var dynamicTypeSizeViewModifier: some View {
        self
            .dynamicTypeSize(.xSmall ... .large)
    }
    
    /// Fixes the dynamic type size of the view to `.large`.
    ///
    /// `.large` corresponds to the **default text size on iPhones**.
    /// This ensures the text inside the view always renders at that default size,
    /// regardless of the user’s dynamic type settings.
    /// Useful for UI elements that require consistent sizing.
    ///
    /// Example:
    /// ```swift
    /// Text("Fixed Size")
    ///     .defaultTypeSizeViewModifier
    /// ```
    var defaultTypeSizeViewModifier: some View {
        self
            .dynamicTypeSize(.large)
    }
    
    @ViewBuilder
    var mapControlButtonBackground: some View {
        if #available(iOS 26.0, *) {
            self
                .background(
                    Color.primary.opacity(0.001),
                    in: .circle
                )
        } else {
            self
                .background(
                    Color.custom.Map.mapControlButtonBackground.color,
                    in: .rect(cornerRadius: 7)
                )
        }
    }
    
    var mapControlButtonShadow: some View {
        self
            .background {
                Color.clear
                    .mapControlButtonBackground
                    .shadow(color: .black.opacity(0.05), radius: 5, x: -1, y: 1)
            }
    }
}




