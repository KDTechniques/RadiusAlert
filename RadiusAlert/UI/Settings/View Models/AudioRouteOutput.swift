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
        print(portType)
        let audioRouteOutputType: AudioRouteOutputTypes? = .allCases.first(where: { $0.rawValue == portType })
        
        guard let audioRouteOutputType else { return .any }
        
        return audioRouteOutputType
    }
    
    func onAudioRouteOutputChange() {
        userDefaultsManager.saveAudioRouteOutputType(selectedAudioRouteOutputType)
    }
}
