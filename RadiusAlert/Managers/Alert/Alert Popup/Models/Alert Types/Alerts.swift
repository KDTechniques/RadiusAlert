//
//  Alerts.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-10-29.
//

import Foundation

extension AlertTypes {
    var alert: AlertModel {
        switch  self {
        case .noConnection:
            return .init(
                title: "No Internet Connection",
                message: "Please check your internet connection and try again.",
                hapticType: .warning,
                actions: [.init(role: .ok)]
            )
            
        case .requestTimedOut:
            return .init(
                title: "Search Request Timed out",
                message: "Your internet connection seems slow. Please check your connection and try again.",
                hapticType: .warning,
                actions: [
                    .init(role: .custom("Try Again")),
                    .init(role: .cancel)
                ]
            )
            
        case .locationPermissionDenied:
            return .init(
                title: "Location Permission Required",
                message: "This app cannot work correctly without location access set to 'Always Allow'. Please enable it in Settings to continue.",
                hapticType: .warning,
                actions: [
                    .init(role: .custom("Open Settings")) { OpenURLTypes.settings.openURL() }
                ]
            )
            
        case .alreadyInRadius:
            return .init(
                title: "Already Within Radius",
                message: "Please reduce the radius to set a meaningful alert.",
                hapticType: .warning,
                actions: [.init(role: .ok)]
            )
            
        case .radiusNotBeyondMinimumDistance:
            return .init(
                title: "Too Close to Set Alert",
                message: "The alert radius must be set at least 1km ahead of your current location.",
                hapticType: .warning,
                actions: [.init(role: .ok)]
            )
            
        case .stopAlertHereConfirmation(let action):
            return .init(
                title: "Are You Sure?",
                message: "This will stop the alert immediately.",
                hapticType: .warning,
                actions: [
                    .init(role: .destructive("OK")) { action() },
                    .init(role: .cancel)
                ]
            )
            
        case .stopAlertOnSubmit(let action):
            return .init(
                title: "Stop Existing Radius Alert?",
                message: "You already have a radius alert set. Do you want to stop it to set a new radius alert?",
                hapticType: .warning,
                actions: [
                    .init(role: .destructive("Yes")) { action() },
                    .init(role: .cancel)
                ]
            )
            
        case .locationPinAlreadyExist(let action):
            return .init(
                title: "Location Already Pinned",
                message: "You may update the existing pin if needed.",
                hapticType: .warning,
                actions: [
                    .init(role: .custom("Update")) { action() },
                    .init(role: .cancel)
                ]
            )
            
        case .addMultipleStops(let searchAction, let manualAction):
            return .init(
                title: "Add Another Stop By:",
                hapticType: .light,
                actions: [
                    .init(role: .custom("Searching for a Location")) { searchAction() },
                    .init(role: .custom("Setting a Pin Manually")) { manualAction() },
                    .init(role: .cancel)
                ]
            )
        }
    }
}
