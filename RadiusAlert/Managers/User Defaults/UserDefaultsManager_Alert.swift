//
//  UserDefaultsManager_Alert.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-28.
//

import Foundation

extension UserDefaultsManager {
    // MARK: - Tone
    
    func saveTone(_ value: String) {
        defaults.set(value, forKey: UserDefaultKeys.tone.rawValue)
    }
    
    func getTone() -> ToneTypes {
        guard
            let toneRawValue: String = defaults.string(forKey: UserDefaultKeys.tone.rawValue),
            let tone: ToneTypes = ToneTypes.allCases.first(where: {$0.rawValue == toneRawValue }) else { return .defaultTone }
        
        return tone
    }
    
    // MARK: - Tone Fade
    
    func getToneFade() -> Bool {
        if defaults.object(forKey: UserDefaultKeys.toneFade.rawValue) == nil {
            return true
        } else {
            return defaults.bool(forKey: UserDefaultKeys.toneFade.rawValue)
        }
    }
    
    func saveToneFade(_ value: Bool) {
        defaults.set(value, forKey: UserDefaultKeys.toneFade.rawValue)
    }
    
    func getToneFadeDuration() -> Double {
        let duration: Double = defaults.double(forKey: UserDefaultKeys.toneFadeDuration.rawValue)
        return duration == 0 ? ToneValues.defaultDuration : duration
    }
    
    func saveFadeDuration(_ value: Double) {
        defaults.set(value, forKey: UserDefaultKeys.toneFadeDuration.rawValue)
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
}
