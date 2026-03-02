//
//  SettingsValidation.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-03-02.
//

import Foundation

// MARK: VALIDATION

extension SettingsViewModel {
    func alertsOnlyVia_DeviceCheck() -> Bool {
        guard selectedAudioRouteOutputType != .any else { return true }
        return currentAudioRouteOutputType == selectedAudioRouteOutputType
    }
}
