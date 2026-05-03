//
//  Tone.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-02.
//

import Foundation

// MARK: - TONE

extension SettingsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    /// If tone fade is enabled, waits for the configured duration and then sets the tone volume to 0.5.
    /// Uses Swift concurrency to avoid blocking the main thread.
    func setToneVolumeToFade() {
        // Exit early if fade behavior is disabled by the user.
        guard isEnabledToneFade else { return }
        
        Task {
            // Delay by the user-selected fade duration before adjusting volume.
            try await Task.sleep(nanoseconds: .seconds(toneFadeDuration))
            // Apply the faded volume level.
            alertManager.setAbsoluteToneVolume(0.5)
        }
    }
    
    /// Returns a user-facing string describing the current tone fade duration.
    func getToneFadeDurationString() -> String {
        // Build a simple "Duration: X sec." label for UI display.
        let defaultText: String = "Duration: "
        let secondaryText: String = "\(toneFadeDuration.int()) sec."
        
        return defaultText + secondaryText
    }
    
    /// Persists the selected tone to UserDefaults when it changes.
    func onToneChange() {
        userDefaultsManager.saveTone(selectedTone.rawValue)
    }
    
    /// Persists the user's preference for tone fade enablement.
    func onToneFadeToggleChange() {
        userDefaultsManager.saveToneFade(isEnabledToneFade)
    }
}

