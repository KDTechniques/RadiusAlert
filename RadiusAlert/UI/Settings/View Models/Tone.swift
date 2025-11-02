//
//  Tone.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-02.
//

import Foundation

extension SettingsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func setToneVolumeToFade() {
        guard isEnabledToneFade else { return }
        
        Task {
            do {
                try await Task.sleep(nanoseconds: .seconds(toneFadeDuration))
                alertManager.setAbsoluteToneVolume(0.5)
            }
        }
    }
    
    func getToneFadeDurationString() -> String {
        let defaultText: String = "Duration: "
        let secondaryText: String = "\(toneFadeDuration.int()) sec."
        
        return defaultText + secondaryText
    }
    
    func onToneChange() {
        userDefaultsManager.saveTone(selectedTone.rawValue)
    }
    
    func onToneFadeToggleChange() {
        userDefaultsManager.saveToneFade(isEnabledToneFade)
    }
}
