//
//  AudioRouteOutput.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-03-02.
//

import Foundation
import AVFoundation

// MARK: AUDIO ROUTE OPUTPUT

extension SettingsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    /// Observes system audio route change notifications and updates the current output type.
    /// - Note: Uses `AVAudioSession.routeChangeNotification` on the main queue and stores
    ///   the mapped `AudioRouteOutputTypes` in view model state.
    func audioRouteChangeObserver() {
        // Listen for audio route changes from AVAudioSession.
        NotificationCenter.default.addObserver(
            forName: AVAudioSession.routeChangeNotification,
            object: AVAudioSession.sharedInstance(),
            queue: .main
        ) { [weak self] _ in
            guard let self else { return }
            
            // Map the current AVAudioSession port to our app-specific output type.
            let audioRouteOutputType: AudioRouteOutputTypes = getCurrentAudioRouteOutputType()
            setCurrentAudioRouteOutputType(audioRouteOutputType)
        }
    }
    
    /// Returns the app-specific audio output type for the current AVAudioSession route.
    /// - Returns: A mapped `AudioRouteOutputTypes` value, or `.allDevice` if no output is found.
    func getCurrentAudioRouteOutputType() -> AudioRouteOutputTypes {
        let route: AVAudioSessionRouteDescription = AVAudioSession.sharedInstance().currentRoute
        let outPut: AVAudioSessionPortDescription? = route.outputs.first
        
        // Default to `.allDevice` when no output port is present.
        guard let outPut else { return .allDevice }
        
        let portType: AVAudioSession.Port = outPut.portType
        let audioRouteOutputType: AudioRouteOutputTypes = .getAudioRouteOutputType(for: portType)
        
        return audioRouteOutputType
    }
    
    /// Persists the selected audio route output type to user defaults.
    /// - Note: Call when the user changes the audio route preference in settings.
    func onAudioRouteOutputChange() {
        userDefaultsManager.saveAudioRouteOutputType(selectedAudioRouteOutputType)
    }
}

