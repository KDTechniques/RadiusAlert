//
//  AlertTypes.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-31.
//

import SwiftUI

/// Defines all alert types used throughout the app.
///
/// Each case represents a specific kind of alert, such as network issues,
/// location permission problems, or radius-related actions.
///
/// Use the `alert` property of each case to get the corresponding `AlertModel`,
/// which includes the alert title, message, haptic feedback, and buttons.
///
/// Example usage:
/// ```swift
/// let alertType: AlertTypes = .noConnection
/// let alertModel = alertType.alert
/// ```
enum AlertTypes: CaseIterable, Hashable {
    case noConnection
    case requestTimedOut
    case locationPermissionDenied
    case alreadyInRadius
    case radiusNotBeyondMinimumDistance
    case stopAlertHereConfirmation(() -> Void)
    case stopAlertOnSubmit(() -> Void)
    
    static var allCases: [AlertTypes] = [
        .alreadyInRadius,
        .locationPermissionDenied,
        .noConnection,
        .requestTimedOut,
        .radiusNotBeyondMinimumDistance,
        .stopAlertHereConfirmation({ }),
        .stopAlertOnSubmit({ })
    ]
    
    // Implement Hashable manually
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
    
    // Implement Equatable manually
    static func == (lhs: AlertTypes, rhs: AlertTypes) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
    
    var rawValue: String {
        switch self {
        case .noConnection:
            return "No Connection"
            
        case .requestTimedOut:
            return "Request Timed Out"
            
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
}

