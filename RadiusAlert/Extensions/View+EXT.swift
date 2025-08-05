//
//  View+EXT.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

extension View {
    func previewModifier() ->  some View {
        self
            .environment(ContentViewModel())
            .environment(MapViewModel())
    }
    
    func alertViewModifier(item: Binding<AlertModel?>) -> some View {
        self
            .alert(item: item) { alertItem in
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
