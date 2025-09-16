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
            .dynamicTypeSizeViewModifier
    }
    
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
    
    var dynamicTypeSizeViewModifier: some View {
        self
            .dynamicTypeSize(.xSmall ... .large)
    }
    
    var defaultTypeSizeViewModifier: some View {
        self
            .dynamicTypeSize(.large)
    }
}
