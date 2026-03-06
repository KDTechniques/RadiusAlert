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
    
    func audioRouteChangeObserver() {
        NotificationCenter.default.addObserver(
            forName: AVAudioSession.routeChangeNotification,
            object: AVAudioSession.sharedInstance(),
            queue: .main
        ) { [weak self] _ in
            guard let self else { return }
            
            let audioRouteOutputType: AudioRouteOutputTypes = getCurrentAudioRouteOutputType()
            setCurrentAudioRouteOutputType(audioRouteOutputType)
        }
    }
    
    func getCurrentAudioRouteOutputType() -> AudioRouteOutputTypes {
        let route: AVAudioSessionRouteDescription = AVAudioSession.sharedInstance().currentRoute
        let outPut: AVAudioSessionPortDescription? = route.outputs.first
        
        guard let outPut else { return .allDevice }
        
        let portType: AVAudioSession.Port = outPut.portType
        let audioRouteOutputType: AudioRouteOutputTypes = .getAudioRouteOutputType(for: portType)
        
        return audioRouteOutputType
    }
    
    func onAudioRouteOutputChange() {
        userDefaultsManager.saveAudioRouteOutputType(selectedAudioRouteOutputType)
    }
}
