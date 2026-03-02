//
//  Tone.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-02.
//

import Foundation
import AVFoundation

// MARK: - TONE

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
    
    func audioRouteChangeObserver() {
        NotificationCenter.default.addObserver(
            forName: AVAudioSession.routeChangeNotification,
            object: AVAudioSession.sharedInstance(),
            queue: .main
        ) { _ in
            let audioRouteOutputType: AudioRouteOutputTypes = self.getCurrentAudioRouteOutputType()
            self.setCurrentAudioRouteOutputType(audioRouteOutputType)
        }
    }
    
    func getCurrentAudioRouteOutputType() -> AudioRouteOutputTypes {
        let route: AVAudioSessionRouteDescription = AVAudioSession.sharedInstance().currentRoute
        let outPut: AVAudioSessionPortDescription? = route.outputs.first
        
        guard let outPut else { return .any }
        
        let portType: String = outPut.portType.rawValue
        let audioRouteOutputType: AudioRouteOutputTypes? = .allCases.first(where: { $0.rawValue == portType })
        
        guard let audioRouteOutputType else { return .any }
        
        return audioRouteOutputType
    }
}
