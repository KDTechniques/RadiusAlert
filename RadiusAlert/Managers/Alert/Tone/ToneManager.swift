//
//  ToneManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-31.
//

import AVFoundation

actor ToneManager {
    // MARK: - ASSIGNED PROPERTIRES
    static let shared = ToneManager()
    private let errorModel: ToneManagerErrorModel.Type = ToneManagerErrorModel.self
    private var player: AVAudioPlayer?
    
    // MARK: - INITIALIZER
    private init() {
        Task {
            await activateAudioSession()
        }
    }
    
    // MARK: - PUBLIC FUNCTIONS
    
    /// Plays a custom tone from the app bundle.
    ///
    /// - Parameters:
    ///   - fileName: The name of the audio file (without extension) located in the app bundle.
    ///   - loopCount: The number of times to loop playback.
    ///                Use `-1` for infinite looping.
    ///
    /// - Notes:
    ///   - Activates the audio session to ensure sounds play even if the device is in silent mode or the screen is locked.
    func playTone(_ fileName: String, loopCount: Int) {
        activateAudioSession()
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            Utilities.log(errorModel.failedToFindAudioFile.errorDescription)
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = loopCount // Infinite loop
            player?.prepareToPlay()
            player?.play()
        } catch {
            Utilities.log(errorModel.failedToInitializePlayer(error).errorDescription)
        }
    }
    
    /// Stops playback and deactivates the audio session.
    func stopTone() {
        player?.stop()
        player = nil
        deactivateAudioSession()
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
