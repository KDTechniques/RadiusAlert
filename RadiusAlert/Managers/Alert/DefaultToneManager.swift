//
//  DefaultToneManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-31.
//

import AVFoundation

final class DefaultToneManager {
    // MARK: - ASSIGNED PROPERTIRES
    static let shared = DefaultToneManager()
    private var player: AVAudioPlayer?
    
    // MARK: - INITIALIZER
    private init() {}
    
    // MARK: - FUNCTIONS
    func playDefaultTone() {
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
        player?.stop()
        player = nil
    }
}
