//
//  HapticManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-31.
//

import UIKit
import CoreHaptics

actor HapticManager {
    //  MARK: - ASSIGNED PROPERTIES
    static let shared = HapticManager()
    private let hapticFeedbackGeneratorWrapper = HapticFeedbackGeneratorWrapper()
    private let errorModel: HapticManagerErrorModel.Type = HapticManagerErrorModel.self
    private var hapticEngine: CHHapticEngine?
    private var player: CHHapticAdvancedPatternPlayer?
    
    // MARK: - INITIALIZER
    init() { }
    
    // MARK: - PUBLIC FUNCTIONS
    
    /// Plays a continuous SOS pattern using haptics (dot-dot-dot, dash-dash-dash, dot-dot-dot).
    /// Loops indefinitely until `stopSOSPattern()` is called.
    func playSOSPattern() {
        guard let engine = hapticEngine else {
            setupHaptics() // Lazily initialize the haptic engine if needed
            return
        }
        
        var events = [CHHapticEvent]()
        let shortDuration: TimeInterval = 0.1
        let longDuration: TimeInterval = 0.3
        let pauseDuration: TimeInterval = 0.1
        var currentTime: TimeInterval = 0
        
        // Common parameters for short and long pulses
        let shortParams = [
            CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0),
            CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        ]
        
        let longParams = shortParams
        
        // Three short pulses (dot-dot-dot)
        for _ in 0..<3 {
            events.append(CHHapticEvent(
                eventType: .hapticTransient,
                parameters: shortParams,
                relativeTime: currentTime
            ))
            
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
            events.append(CHHapticEvent(eventType: .hapticTransient, parameters: shortParams, relativeTime: currentTime))
            currentTime += shortDuration + pauseDuration
        }
        
        // Attempt to create and start a looping advanced player
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            player = try engine.makeAdvancedPlayer(with: pattern)
            player?.loopEnabled = true
            try player?.start(atTime: 0)
        } catch {
            Utilities.log(errorModel.failedToPlaySOSPattern(error).errorDescription)
        }
    }
    
    /// Stops the currently playing SOS haptic pattern.
    func stopSOSPattern() {
        do {
            try player?.stop(atTime: 1)
        } catch {
            Utilities.log(errorModel.failedToStopHaptics(error).errorDescription)
        }
    }
    
    /// Triggers a one-time haptic feedback for the given type.
    func vibrate(type: HapticTypes) {
        switch type {
        case .success:
            hapticFeedbackGeneratorWrapper.notificationOccurred(.success)
        case .error:
            hapticFeedbackGeneratorWrapper.notificationOccurred(.error)
        case .warning:
            hapticFeedbackGeneratorWrapper.notificationOccurred(.warning)
        case .light:
            hapticFeedbackGeneratorWrapper.impactOccurred(style: .light)
        case .soft:
            hapticFeedbackGeneratorWrapper.impactOccurred(style: .soft)
        case .medium:
            hapticFeedbackGeneratorWrapper.impactOccurred(style: .medium)
        case .rigid:
            hapticFeedbackGeneratorWrapper.impactOccurred(style: .rigid)
        case .heavy:
            hapticFeedbackGeneratorWrapper.impactOccurred(style: .heavy)
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    /// Initializes the haptic engine and configures the reset handler.
    private func setupHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
            
            // Automatically restart engine if it stops
            hapticEngine?.resetHandler = {
                Task { @MainActor [weak self] in
                    try await self?.hapticEngine?.start()
                }
            }
        } catch {
            Utilities.log(errorModel.failedToStartHapticEngine(error).errorDescription)
        }
    }
}
