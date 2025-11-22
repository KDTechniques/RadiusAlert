//
//  SettingsVM_Bindings.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-02.
//

import SwiftUI

extension SettingsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func mapStyleButtonVisibilityBinding() -> Binding<Bool> {
        return .init(get: { self.showMapStyleButton }, set: setShowMapStyleButton)
    }
    
    func toneFadeToggleBinding() -> Binding<Bool> {
        return .init(get: { self.isEnabledToneFade }, set: withAnimation { setIsEnabledToneFade })
    }
    
    func toneFadeDurationBinding() -> Binding<Double> {
        return .init(get: { self.toneFadeDuration }, set: setToneFadeDuration)
    }
    
    func spokenUserNameTextFieldTextBinding() -> Binding<String> {
        return .init(get: { self.spokenAlertValues.userName }, set: setSpokenUserNameTextFieldText)
    }
    
    func selectedVoiceNameBinding() -> Binding<String> {
        return .init(get: { self.spokenAlertValues.voice }, set: setSelectedVoiceName)
    }
    
    func speakingRateBinding() -> Binding<CGFloat> {
        return .init(get: { self.spokenAlertValues.speakingRate }, set: setSpeakingRate)
    }
    
    func pitchRateBinding() -> Binding<CGFloat> {
        return .init(get: { self.spokenAlertValues.pitchRate }, set: setPitchRate)
    }
    
    func isOnSpokenAlertBinding() -> Binding<Bool> {
        return .init(get: { self.spokenAlertValues.isOnSpokenAlert }, set: SetIsOnSpokenAlert)
    }
}
