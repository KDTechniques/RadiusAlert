//
//  SpokenAlert .swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-16.
//

import Foundation

extension SettingsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    /// Handles editing changes for the spoken alert preview slider.
    /// - Parameter value: `true` while the slider is being dragged; `false` when editing ends.
    /// - Note: Triggers a preview speak only when editing ends (i.e., when `value` is `false`).
    func onSpokenAlertSliderEditingChange(_ value: Bool) {
        // Only speak when the user finishes dragging the slider.
        guard !value else { return }
        Task { await spokenAlertSpeakAction() }
    }
    
    /// Speaks a preview phrase using the current spoken alert settings.
    /// - Parameter with: An optional location title to personalize the phrase.
    /// - Note: Uses `textToSpeechManager` with the configured voice, speaking rate, and pitch.
    func spokenAlertSpeakAction(with locationTitle: String? = nil) async {
        // Build the phrase based on user name and optional location title.
        let text: String = SpokenAlertValues.getPhrase(
            userName: spokenAlert.userName,
            locationTitle: locationTitle ?? nil
        )
        
        // Speak using the current voice, rate, and pitch from settings.
        await textToSpeechManager.speak(
            text: text,
            voice: spokenAlert.voice,
            spokenRate: Float(spokenAlert.speakingRate),
            pitchRate: Float(spokenAlert.pitchRate)
        )
    }
    
    /// Loads available voice names once and caches them in settings.
    /// - Note: Skips fetching if `voiceNamesArray` is already populated.
    func getNSetVoiceNamesArray() async {
        // Avoid refetching if we already have the list of voices.
        guard voiceNamesArray.isEmpty else { return }
        let tempArray: [String] = await textToSpeechManager.getAvailableVoiceNames()
        setVoiceNamesArray(tempArray)
    }
    
    /// Stops any ongoing speech when the Spoken Alert view disappears.
    /// - Note: Ensures no audio continues after leaving the screen.
    func onSpokenAlertViewDisappear() {
        Task { await textToSpeechManager.stopSpeak() }
    }
}

