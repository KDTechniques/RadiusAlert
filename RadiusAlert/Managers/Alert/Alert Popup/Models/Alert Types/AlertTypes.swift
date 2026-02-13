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
    case noConnection(viewLevel: AlertViewLevels)
    case requestTimedOut(viewLevel: AlertViewLevels)
    case locationPermissionDenied(viewLevel: AlertViewLevels)
    case alreadyInRadius(viewLevel: AlertViewLevels)
    case radiusNotBeyondMinimumDistance(viewLevel: AlertViewLevels)
    case stopSingleAlertConfirmation(viewLevel: AlertViewLevels, () -> Void)
    case stopAllAlertsConfirmation(viewLevel: AlertViewLevels, () -> Void)
    case stopAlertOnSubmit(viewLevel: AlertViewLevels, () -> Void)
    case locationPinAlreadyExist(viewLevel: AlertViewLevels, () -> Void)
    case addMultipleStops(viewLevel: AlertViewLevels, search: () -> Void, manual: () -> Void)
    case maxMarkerLimitReached(viewLevel: AlertViewLevels)
    case markerAlreadyExist(ViewLevel: AlertViewLevels)
    
    static var allCases: [AlertTypes] = [
        .alreadyInRadius(viewLevel: .content),
        .locationPermissionDenied(viewLevel: .content),
        .noConnection(viewLevel: .content),
        .requestTimedOut(viewLevel: .content),
        .radiusNotBeyondMinimumDistance(viewLevel: .content),
        .stopSingleAlertConfirmation(viewLevel: .content, {}),
        .stopAllAlertsConfirmation(viewLevel: .content, {}),
        .stopAlertOnSubmit(viewLevel: .content, {}),
        .locationPinAlreadyExist(viewLevel: .content, {}),
        .addMultipleStops(viewLevel: .content, search: {}, manual: {}),
        .maxMarkerLimitReached(viewLevel: .content),
        .markerAlreadyExist(ViewLevel: .content)
    ]
    
    // Implement Hashable manually
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.rawValue)
    }
    
    // Implement Equatable manually
    static func == (lhs: Self, rhs: Self) -> Bool {
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
            
        case .stopSingleAlertConfirmation:
            return "Stop Single Alert Confirmation"
            
        case .stopAllAlertsConfirmation:
            return "Stop All Alerts Confirmation"
            
        case .stopAlertOnSubmit:
            return "Stop Alert on Submit"
            
        case .locationPinAlreadyExist:
            return "Location Already Pinned"
            
        case .addMultipleStops:
            return "Add Multiple Stops"
            
        case .maxMarkerLimitReached:
            return "Max Marker Limit Reached"
            
        case .markerAlreadyExist:
            return "Marker Already Exist"
        }
    }
}

