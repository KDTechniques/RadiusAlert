//
//  AudioRouteOutput.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-03-02.
//

import Foundation

// MARK: AUDIO ROUTE OPUTPUT

extension SettingsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func onAudioRouteOutputChange() {
        userDefaultsManager.saveAudioRouteOutputType(selectedAudioRouteOutputType)
    }
}
