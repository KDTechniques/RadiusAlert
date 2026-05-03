//
//  AutoAlertStop.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-03-01.
//

import Foundation

// MARK: AUTO ALERT STOP

extension SettingsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    /// Persists the Auto Alert Stop toggle state to user defaults.
    /// - Note: Call when the user enables or disables automatic alert stopping.
    func onAutoAlertStopToggleChange() {
        userDefaultsManager.saveAutoAlertStop(isEnableAutoAlertStop)
    }
    
    /// Returns a localized-friendly string describing the auto-stop duration.
    /// - Returns: A string like "Duration: 10 sec." based on `autoAlertStopDuration`.
    func getAutoAlertStopDurationString() -> String {
        let defaultText: String = "Duration: "
        let secondaryText: String = "\(autoAlertStopDuration.int()) sec."
        
        return defaultText + secondaryText
    }
    
    /// Schedules the provided action to run after the auto-stop duration, if enabled.
    /// - Parameter action: The closure to execute when the auto-stop timer completes.
    /// - Note: Does nothing when Auto Alert Stop is disabled.
    func handleAlertToStopAutomatically(_ action: @escaping () -> Void) {
        // Exit early if auto-stop is turned off.
        guard isEnableAutoAlertStop else { return }
        
        Task {
            // Wait for the configured duration before invoking the action.
            try await Task.sleep(nanoseconds: .seconds(autoAlertStopDuration))
            action()
        }
    }
}

