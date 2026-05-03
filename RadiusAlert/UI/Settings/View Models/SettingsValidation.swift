//
//  SettingsValidation.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-03-02.
//

import Foundation

// MARK: VALIDATION

extension SettingsViewModel {
    /// Validates whether alerts should play only through the selected audio route.
    /// - Returns: `true` if the user selected `.allDevice` (no restriction) or if the
    ///   current output route matches the user's selected route; otherwise `false`.
    func alertsOnlyVia_DeviceCheck() -> Bool {
        // If user chose "All Device", allow alerts regardless of the current route.
        guard selectedAudioRouteOutputType != .allDevice else { return true }
        // Otherwise, require the current route to match the selected route.
        return currentAudioRouteOutputType == selectedAudioRouteOutputType
    }
}
