//
//  AutoAlertStop.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-03-01.
//

import Foundation

extension SettingsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func onAutoAlertStopToggleChange() {
        userDefaultsManager.saveAutoAlertStop(isEnableAutoAlertStop)
    }
    
    func getAutoAlertStopDurationString() -> String {
        let defaultText: String = "Duration: "
        let secondaryText: String = "\(autoAlertStopDuration.int()) sec."
        
        return defaultText + secondaryText
    }
    
    func handleAlertToStopAutomatically(_ action: @escaping () -> Void) {
        guard isEnableAutoAlertStop else { return }
        
        Task {
            do {
                try await Task.sleep(nanoseconds: .seconds(autoAlertStopDuration))
                action()
            }
        }
    }
}
