//
//  UserDefaultsManager_Alert.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-28.
//

import Foundation

/// If the stored value is nil, we return true so the user can experience the feature by default.
/// If the user explicitly disables it, we preserve that choice.
///
/// Example:
/// ```swift
/// if defaults.object(forKey: UserDefaultKeys.toneFade.rawValue).isNil() {
///     return true
/// }
/// ```

extension UserDefaultsManager {
    // MARK: - Tone
    
    func saveTone(_ value: String) {
        defaults.set(value, forKey: UserDefaultKeys.tone.rawValue)
    }
    
    func getTone() -> ToneTypes {
        guard
            let rawValue: String = defaults.string(forKey: UserDefaultKeys.tone.rawValue),
            let tone: ToneTypes = .init(rawValue: rawValue) else { return .defaultTone }
        
        return tone
    }
    
    // MARK: - Tone Fade
    
    func getToneFade() -> Bool {
        guard defaults.object(forKey: UserDefaultKeys.toneFade.rawValue) != nil else { return true }
        return defaults.bool(forKey: UserDefaultKeys.toneFade.rawValue)
    }
    
    func saveToneFade(_ boolean: Bool) {
        defaults.set(boolean, forKey: UserDefaultKeys.toneFade.rawValue)
    }
    
    func getToneFadeDuration() -> Double {
        let duration: Double = defaults.double(forKey: UserDefaultKeys.toneFadeDuration.rawValue)
        return duration == 0 ? ToneValues.toneFadeDefaultDuration : duration
    }
    
    func saveFadeDuration(_ duration: Double) {
        defaults.set(duration, forKey: UserDefaultKeys.toneFadeDuration.rawValue)
    }
    
    // MARK: - Spoken Alert
    
    func getSpokenAlert() -> SpokenAlertModel {
        guard let data: Data = defaults.data(forKey: UserDefaultKeys.spokenAlert.rawValue) else { return .initialValues }
        
        do {
            let model: SpokenAlertModel = try JSONDecoder().decode(SpokenAlertModel.self, from: data)
            return model
        } catch let error {
            print("❌: Error getting spoken alert from user defaults. \(error.localizedDescription)")
            return .initialValues
        }
    }
    
    func saveSpokenAlert(_ value: SpokenAlertModel) {
        do {
            let data: Data = try JSONEncoder().encode(value)
            defaults.set(data, forKey: UserDefaultKeys.spokenAlert.rawValue)
        } catch let error {
            print("❌: Error saving spoken alert to user defaults. \(error.localizedDescription)")
        }
    }
    
    // MARK: - Auto Alert Stop
    
    func getAutoAlertStop() -> Bool {
        guard defaults.object(forKey: UserDefaultKeys.autoAlertStop.rawValue) != nil else { return true }
        return defaults.bool(forKey: UserDefaultKeys.autoAlertStop.rawValue)
    }
    
    func saveAutoAlertStop(_ boolean: Bool) {
        defaults.set(boolean, forKey: UserDefaultKeys.autoAlertStop.rawValue)
    }
    
    func getAutoAlertStopDuration() -> Double {
        let duration: Double = defaults.double(forKey: UserDefaultKeys.autoAlertStopDuration.rawValue)
        return duration == 0 ? AlertValues.autoAlertStopDefaultDuration : duration
    }
    
    func saveAutoAlertStopDuration(_ duration: Double) {
        defaults.set(duration, forKey: UserDefaultKeys.autoAlertStopDuration.rawValue)
    }
    
    // MARK: - Audio Route Output Type
    
    func getAudioRouteOutputType() -> AudioRouteOutputTypes {
        guard
            let rawValue: String = defaults.string(forKey: UserDefaultKeys.audioRouteOutput.rawValue),
            let type: AudioRouteOutputTypes = .init(rawValue: rawValue) else { return .allDevice }
        
        return type
    }
    
    func saveAudioRouteOutputType(_ type: AudioRouteOutputTypes) {
        defaults.set(type.rawValue, forKey: UserDefaultKeys.audioRouteOutput.rawValue)
    }
}
