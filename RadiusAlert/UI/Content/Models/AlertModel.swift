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
        AlertManager.shared.alertItem = alertType
        await HapticManager.shared.vibrate(type: alertType.hapticType)
    }
}

enum AlertTypes {
    // MARK: - Reusable
    
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
    
    
}
