//
//  TextToSpeechManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-16.
//

import AVFoundation

/// A lightweight, concurrency-safe text-to-speech helper built on AVFoundation.
///
/// This actor isolates speech operations and exposes convenience APIs
/// for speaking text and enumerating available system voices.
actor TextToSpeechManager {
    // MARK: - ASSIGNED PROPERTIES
    static let shared = TextToSpeechManager()
    let synthesizer = AVSpeechSynthesizer()
    
    // MARK: - INITIALIZER
    private init() { }
    
    // MARK: - PUBLIC FUNCTIONS
    
    /// Speaks the provided text using AVSpeechSynthesizer.
    ///
    /// - Parameters:
    ///   - text: The text to be spoken.
    ///   - voiceIdentifier: Optional identifier of a specific `AVSpeechSynthesisVoice` to use.
    ///     If `nil`, the system selects a default voice that matches the current locale.
    ///
    /// - Discussion:
    ///   This method hops to the main actor to interact with `AVSpeechSynthesizer`,
    ///   which is a UI-adjacent API. A new synthesizer instance is created for the
    ///   request and begins speaking immediately. If `voiceIdentifier` is provided
    ///   but doesn't resolve to a valid voice, the system default is used.
    ///
    /// - Note: Speech begins asynchronously and this call does not block until
    ///   completion.
    func speak(text: String, voice: String) async {
        synthesizer.stopSpeaking(at: .immediate)
        
        let voiceIdentifier: String? = getVoiceIdentifier(for: voice)
        let utterance = AVSpeechUtterance(string: text)
        
        utterance.rate = 0.5  // Range: 0.0 (slow) → 1.0 (fast)
        utterance.pitchMultiplier = 1.0  // Range: 0.5 (low) → 2.0 (high)
        
        // Use selected voice if provided, otherwise default system language voice
        if let voiceIdentifier,
           let voice = AVSpeechSynthesisVoice(identifier: voiceIdentifier) {
            utterance.voice = voice
        }
        
        synthesizer.speak(utterance)
        
    }
    
    /// Returns the display names of all available system speech voices.
    ///
    /// - Returns: An array of human-readable voice names (e.g., "Samantha", "Daniel").
    ///   Useful for presenting choices in UI. Names are localized and may vary by device.
    func getAvailableVoiceNames() -> [String] {
        return AVSpeechSynthesisVoice.speechVoices().map { $0.name }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    
    /// Resolves a voice identifier by matching on a human-readable voice name.
    ///
    /// - Parameter name: A (partial) display name to search for (case-sensitive contains match).
    /// - Returns: The matching voice's identifier if found; otherwise, `nil`.
    /// - Note: If multiple voices contain the provided name, the first match is returned.
    private func getVoiceIdentifier(for name: String) -> String? {
        return AVSpeechSynthesisVoice.speechVoices()
            .first(where: { $0.name.contains(name) })?
            .identifier
    }
}
