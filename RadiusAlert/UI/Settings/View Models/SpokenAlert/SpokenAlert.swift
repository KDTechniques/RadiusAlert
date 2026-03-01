//
//  SpokenAlert .swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-16.
//

import Foundation

extension SettingsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func onSpokenAlertSliderEditingChange(_ value: Bool) {
        guard !value else { return }
        Task { await spokenAlertSpeakAction() }
    }
    
    func spokenAlertSpeakAction(with locationTitle: String? = nil) async {
        let text: String = SpokenAlertValues.getPhrase(
            userName: spokenAlert.userName,
            locationTitle: locationTitle ?? nil
        )
       
        await textToSpeechManager.speak(
            text: text,
            voice: spokenAlert.voice,
            spokenRate: Float(spokenAlert.speakingRate),
            pitchRate: Float(spokenAlert.pitchRate)
        )
    }
    
    func getNSetVoiceNamesArray() async {
        guard voiceNamesArray.isEmpty else { return }
        let tempArray: [String] = await textToSpeechManager.getAvailableVoiceNames()
        setVoiceNamesArray(tempArray)
    }
    
    func onSpokenAlertViewDisappear() {
        Task { await textToSpeechManager.stopSpeak() }
    }
}
