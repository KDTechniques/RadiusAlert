//
//  SettingsVM_Bindings.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-02.
//

import SwiftUI

// MARK: BINDINGS

extension SettingsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func mapStyleButtonVisibilityBinding() -> Binding<Bool> {
        return .init(
            get: { [weak self] in
                guard let self else { return false }
                return hideMapStyleButton
            }, set: setHideShowMapStyleButton)
    }
    
    func toneFadeToggleBinding() -> Binding<Bool> {
        return .init(
            get: { [weak self] in
                guard let self else { return false }
                return isEnabledToneFade
            }, set: withAnimation { setIsEnabledToneFade })
    }
    
    func toneFadeDurationBinding() -> Binding<Double> {
        return .init(
            get: {  [weak self] in
                guard let self else { return .zero }
                return toneFadeDuration
            }, set: setToneFadeDuration)
    }
    
    func spokenUserNameTextFieldTextBinding() -> Binding<String> {
        return .init(
            get: { [weak self] in
                guard let self else { return "" }
                return spokenAlert.userName
            }, set: setSpokenUserNameTextFieldText)
    }
    
    func selectedVoiceNameBinding() -> Binding<String> {
        return .init(
            get: { [weak self] in
                guard let self else { return "" }
                return spokenAlert.voice
            }, set: setSelectedVoiceName)
    }
    
    func speakingRateBinding() -> Binding<CGFloat> {
        return .init(
            get: { [weak self] in
                guard let self else { return .zero }
                return spokenAlert.speakingRate
            }, set: setSpeakingRate)
    }
    
    func pitchRateBinding() -> Binding<CGFloat> {
        return .init(
            get: { [weak self] in
                guard let self else { return .zero }
                return spokenAlert.pitchRate
            }, set: setPitchRate)
    }
    
    func isOnSpokenAlertBinding() -> Binding<Bool> {
        return .init(
            get: { [weak self] in
                guard let self else { return false }
                return spokenAlert.isOnSpokenAlert
            }, set: SetIsOnSpokenAlert)
    }
    
    func autoAlertStopToggleBinding() -> Binding<Bool> {
        return .init(
            get: { [weak self] in
                guard let self else { return false }
                return isEnableAutoAlertStop
            }, set: withAnimation { setAutoAlertStop })
    }
    
    func autoAlertStopDurationBinding() -> Binding<Double> {
        return .init(
            get: { [weak self] in
                guard let self else { return .zero }
                return autoAlertStopDuration
            }, set: setAutoAlertStopDuration)
    }
    
    func selectedAudioRouteOutputTypeBinding() -> Binding<AudioRouteOutputTypes> {
        return .init(
            get: { [weak self] in
                guard let self else { return .allDevice }
                return selectedAudioRouteOutputType
            }, set: setSelectedAudioRouteOutputType)
    }
}
