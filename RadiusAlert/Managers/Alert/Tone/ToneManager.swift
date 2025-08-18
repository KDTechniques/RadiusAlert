//
//  ToneManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-31.
//

import AVFoundation

final class ToneManager {
    // MARK: - ASSIGNED PROPERTIRES
    static let shared = ToneManager()
    private let errorModel: ToneManagerErrorModel.Type = ToneManagerErrorModel.self
    private var player: AVAudioPlayer?
    
    // MARK: - INITIALIZER
    private init() { activateAudioSession() }
    
    // MARK: - PUBLIC FUNCTIONS
    
    /// Plays the default bundled tone (`tone.mp3`) in an infinite loop.
    func playDefaultTone() {
        activateAudioSession()
        
        guard let url = Bundle.main.url(forResource: "tone", withExtension: "mp3") else {
            Utilities.log(errorModel.failedToFindAudioFile.errorDescription)
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1 // Infinite loop
            player?.prepareToPlay()
            player?.play()
        } catch {
            Utilities.log(errorModel.failedToInitializePlayer(error).errorDescription)
        }
    }
    
    /// Stops playback and deactivates the audio session.
    func stopDefaultTone() {
        deactivateAudioSession()
        player?.stop()
        player = nil
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    /// Configures and activates the audio session for playback.
    ///
    /// - `.playback` category:
    ///   Ensures sounds play even when the device is in silent mode or the screen is locked.
    ///
    /// - `.duckOthers`:
    ///   Lowers the volume of background audio (e.g., Music, Spotify) instead of stopping it,
    ///   making the alert noticeable without fully interrupting media.
    ///
    /// - `.interruptSpokenAudioAndMixWithOthers`:
    ///   Temporarily pauses spoken audio (e.g., Podcasts, VoiceOver) while still mixing with music,
    ///   ensuring the alert tone is clear and not masked.
    private func activateAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.duckOthers, .interruptSpokenAudioAndMixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true, options: [.notifyOthersOnDeactivation])
        } catch {
            Utilities.log(errorModel.failedToActivateAudioSession(error).errorDescription)
        }
    }
    
    /// Deactivates the audio session.
    private func deactivateAudioSession() {
        do  {
            try AVAudioSession.sharedInstance().setActive(false, options: [.notifyOthersOnDeactivation])
        } catch {
            Utilities.log(errorModel.failedToDeactivateAudioSession(error).errorDescription)
        }
    }
}
