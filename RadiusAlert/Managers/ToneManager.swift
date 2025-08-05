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
    private var player: AVAudioPlayer?
    
    // MARK: - INITIALIZER
    private init() { activateAudioSession() }
    
    // MARK: - PUBLIC FUNCTIONS
    func playDefaultTone() {
        activateAudioSession()
        
        guard let url = Bundle.main.url(forResource: "tone", withExtension: "mp3") else {
            print("tone.mp3 file not found in the bundle!")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1   // Loop infinitely
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Failed to initialize audio player:", error)
        }
    }
    
    func stopDefaultTone() {
        deactivateAudioSession()
        player?.stop()
        player = nil
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func activateAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.duckOthers, .interruptSpokenAudioAndMixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to activate audio session: \(error)")
        }
    }
    
    private func deactivateAudioSession() {
        do  {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to deactivate audio session: \(error)")
        }
    }
}
