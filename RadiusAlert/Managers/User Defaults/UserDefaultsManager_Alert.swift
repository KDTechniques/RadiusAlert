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
/// if defaults.object(forKey: keys.toneFade.rawValue) == nil {
///     return true
/// }
/// ```

extension UserDefaultsManager {
    // MARK: - Tone
    
    func saveTone(_ value: String) {
        defaults.set(value, forKey: keys.tone.rawValue)
    }
    
    func getTone() -> ToneTypes {
        guard
            let toneRawValue: String = defaults.string(forKey: keys.tone.rawValue),
            let tone: ToneTypes = ToneTypes.allCases.first(where: {$0.rawValue == toneRawValue }) else { return .defaultTone }
        
        return tone
    }
    
    // MARK: - Tone Fade
    
    func getToneFade() -> Bool {
        if defaults.object(forKey: keys.toneFade.rawValue) == nil {
            return true
        } else {
            return defaults.bool(forKey: keys.toneFade.rawValue)
        }
    }
    
    func saveToneFade(_ boolean: Bool) {
        defaults.set(boolean, forKey: keys.toneFade.rawValue)
    }
    
    func getToneFadeDuration() -> Double {
        let duration: Double = defaults.double(forKey: keys.toneFadeDuration.rawValue)
        return duration == 0 ? ToneValues.toneFadeDefaultDuration : duration
    }
    
    func saveFadeDuration(_ duration: Double) {
        defaults.set(duration, forKey: keys.toneFadeDuration.rawValue)
    }
    
    // MARK: - Spoken Alert
    
    func getSpokenAlert() -> SpokenAlertModel {
        guard let data: Data = defaults.data(forKey: keys.spokenAlert.rawValue) else { return .initialValues }
        
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
            defaults.set(data, forKey: keys.spokenAlert.rawValue)
        } catch let error {
            print("❌: Error saving spoken alert to user defaults. \(error.localizedDescription)")
        }
    }
    
    // MARK: - Auto Alert Stop
    
    func getAutoAlertStop() -> Bool {
        if defaults.object(forKey: keys.autoAlertStop.rawValue) == nil {
            return true
        } else {
            return defaults.bool(forKey: keys.toneFade.rawValue)
        }
    }
    
    func saveAutoAlertStop(_ boolean: Bool) {
        defaults.set(boolean, forKey: keys.autoAlertStop.rawValue)
    }
    
    func getAutoAlertStopDuration() -> Double {
        let duration: Double = defaults.double(forKey: keys.autoAlertStopDuration.rawValue)
        return duration == 0 ? AlertValues.autoAlertStopDefaultDuration : duration
    }
    
    func saveAutoAlertStopDuration(_ duration: Double) {
        defaults.set(duration, forKey: keys.autoAlertStopDuration.rawValue)
    }
}
