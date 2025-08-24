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

enum AlertTypes: CaseIterable, Hashable {
    case noConnection
    case locationPermissionDenied
    case alreadyInRadius
    case radiusNotBeyondMinimumDistance
    case stopAlertHereConfirmation(() -> Void)
    case stopAlertOnSubmit((Bool) -> Void)
    
    static var allCases: [AlertTypes] = [
        .alreadyInRadius,
        .locationPermissionDenied,
        .noConnection,
        .radiusNotBeyondMinimumDistance,
        .stopAlertHereConfirmation({ }),
        .stopAlertOnSubmit({ _ in })
    ]
    
    // Implement Hashable manually
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
    
    // Implement Equatable manually
    static func == (lhs: AlertTypes, rhs: AlertTypes) -> Bool {
        switch (lhs, rhs) {
        case (.noConnection, .noConnection),
            (.locationPermissionDenied, .locationPermissionDenied),
            (.alreadyInRadius, .alreadyInRadius),
            (.radiusNotBeyondMinimumDistance, .radiusNotBeyondMinimumDistance),
            (.stopAlertHereConfirmation, .stopAlertHereConfirmation),
            (.stopAlertOnSubmit, .stopAlertOnSubmit):
            return true
        default:
            return false
        }
    }
    
    var rawValue: String {
        switch self {
        case .noConnection:
            return "No Connection"
            
        case .locationPermissionDenied:
            return "Location Permission Denied"
            
        case .alreadyInRadius:
            return "Already in Radius"
            
        case .radiusNotBeyondMinimumDistance:
            return "Radius Not Beyond Minimum Distance"
            
        case .stopAlertHereConfirmation(_):
            return "Stop Alert Here Confirmation"
            
        case .stopAlertOnSubmit(_):
            return "Stop Alert on Submit"
        }
    }
    
    var alert: AlertModel {
        switch  self {
        case .noConnection:
            return .init(
                title: "No Internet Connection",
                message: "Please check your internet connection and try again.",
                hapticType: .warning,
                primaryAction: .default(Text("OK"))
            )
            
        case .locationPermissionDenied:
            return .init(
                title: "Location Permission Required",
                message: "This app cannot work correctly without location access set to 'Always Allow'. Please enable it in Settings to continue.",
                hapticType: .warning,
                primaryAction: .default(Text("Go to Settings")) { OpenURLTypes.settings.openURL() }
            )
            
        case .alreadyInRadius:
            return .init(
                title: "Already Within Radius",
                message: "Please reduce the radius to set a meaningful alert.",
                hapticType: .warning,
                primaryAction: .default(Text("OK"))
            )
            
        case .radiusNotBeyondMinimumDistance:
            return .init(
                title: "Too Close to Set Alert",
                message: "The alert radius must be set at least 1km ahead of your current location.",
                hapticType: .warning,
                primaryAction: .default(Text("OK"))
            )
            
        case .stopAlertHereConfirmation(let action):
            return .init(
                title: "Are You Sure?",
                message: "This will stop the alert immediately.",
                hapticType: .warning,
                primaryAction: .destructive(Text("OK")) { action() },
                secondaryAction: .cancel()
            )
            
        case .stopAlertOnSubmit(let action):
            return .init(
                title: "Stop Existing Radius Alert?",
                message: "You already have a radius alert set. Do you want to stop it to set a new radius alert?",
                hapticType: .warning,
                primaryAction: .destructive(Text("Yes")) { action(true) },
                secondaryAction: .cancel()
            )
        }
    }
}
