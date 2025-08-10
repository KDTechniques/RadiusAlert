//
//  AlertModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-05.
//

import SwiftUI

struct AlertModel: Identifiable {
    // MARK: - PROPERTIES
    let id              : String = UUID().uuidString
    let title           : String
    let message         : String
    let hapticType      : HapticTypes
    let primaryAction   : Alert.Button
    let secondaryAction : Alert.Button?
    
    // MARK: - INITIALIZER
    init(title: String, message: String = "", hapticType: HapticTypes, primaryAction: Alert.Button, secondaryAction: Alert.Button? = nil) {
        self.title              = title
        self.message            = message
        self.hapticType         = hapticType
        self.primaryAction      = primaryAction
        self.secondaryAction    = secondaryAction
    }
}

// MARK: - FUNCTIONS
/// This function simplifies the process of displaying an alert item, eliminating the need to use `isPresented` for each alert we create.
func showAlert(_ alertType: AlertModel) {
    Task  {
        await HapticManager.shared.vibrate(type: alertType.hapticType)
        AlertManager.shared.alertItem = alertType
    }
}

enum AlertTypes {
    // MARK: - noConnection
    static let noConnection: AlertModel = .init(
        title: "No Internet Connection",
        message: "Please check your internet connection and try again.",
        hapticType: .warning,
        primaryAction: .default(Text("OK"))
    )
    
    static let alreadyInRadius: AlertModel = .init(
        title: "Already Within Radius",
        message: "Please reduce the radius to set a meaningful alert.",
        hapticType: .warning,
        primaryAction: .default(Text("OK"))
    )
    
    static let radiusNotBeyondMinimumDistance: AlertModel = .init(
        title: "Too Close to Set Alert",
        message: "The alert radius must be set at least 1km ahead of your current location.",
        hapticType: .warning,
        primaryAction: .default(Text("OK"))
    )
    
    static func stopAlertHereConfirmation(_ action: @escaping () -> Void) -> AlertModel {
        .init(
            title: "Are You Sure?",
            message: "This will stop the alert immediately.",
            hapticType: .warning,
            primaryAction: .destructive(Text("OK")) { action() },
            secondaryAction: .cancel()
        )
    }
    
    static func stopAlertOnSubmit(_ action: @escaping (Bool) -> Void) -> AlertModel {
        .init(
            title: "Stop Existing Radius Alert?",
            message: "You already have a radius alert set. Do you want to stop it to set a new radius alert?",
            hapticType: .warning,
            primaryAction: .destructive(Text("Yes")) { action(true) },
            secondaryAction: .cancel()
        )
    }
}
