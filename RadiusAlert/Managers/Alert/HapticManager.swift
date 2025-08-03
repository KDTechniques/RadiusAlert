//
//  HapticManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-31.
//

import CoreHaptics

final class HapticManager {
    //  MARK: - ASSIGNED PROPERTIES
    static let shared = HapticManager()
    private var hapticEngine: CHHapticEngine?
    private var player: CHHapticAdvancedPatternPlayer?
    
    // MARK: - INITIALIZER
    init() { }
    
    // MARK: - PUBLIC FUNCTIONS
    func playSOSPattern() {
        guard let engine = hapticEngine else {
            setupHaptics()
            return
        }
        
        var events = [CHHapticEvent]()
        let shortDuration: TimeInterval = 0.1
        let longDuration: TimeInterval = 0.3
        let pauseDuration: TimeInterval = 0.1
        
        var currentTime: TimeInterval = 0
        
        let shortParams = [
            CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
            CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        ]
        
        let longParams = [
            CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
            CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        ]
        
        // Three short pulses (dot-dot-dot)
        for _ in 0..<3 {
            events.append(
                CHHapticEvent(eventType: .hapticTransient, parameters: shortParams, relativeTime: currentTime)
            )
            currentTime += shortDuration + pauseDuration
        }
        
        // Three long pulses (dash-dash-dash)
        for _ in 0..<3 {
            events.append(CHHapticEvent(
                eventType: .hapticContinuous,
                parameters: longParams,
                relativeTime: currentTime,
                duration: longDuration
            ))
            currentTime += longDuration + pauseDuration
        }
        
        // Three short pulses (dot-dot-dot)
        for _ in 0..<3 {
            events.append(CHHapticEvent(
                eventType: .hapticTransient,
                parameters: shortParams,
                relativeTime: currentTime
            ))
            currentTime += shortDuration + pauseDuration
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            player = try engine.makeAdvancedPlayer(with: pattern)
            player?.loopEnabled = true
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play SOS pattern: \(error.localizedDescription)")
        }
    }
    
    func stopSOSPattern() {
        do {
            try player?.stop(atTime: 0)
        } catch {
            print("Failed to stop haptic: \(error.localizedDescription)")
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func setupHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
            hapticEngine?.resetHandler = { [weak self] in
                try? self?.hapticEngine?.start()
            }
        } catch {
            print("Error starting haptic engine: \(error.localizedDescription)")
        }
    }
}
