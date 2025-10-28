//
//  UserDefaultsManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-19.
//

import Foundation

struct UserDefaultsManager {
    let defaults: UserDefaults = .init()
    
    // MARK: Dark Mode
    func saveDarkMode(_ value: String) {
        defaults.set(value, forKey: UserDefaultKeys.darkMode.rawValue)
    }
    
    func getDarkMode() -> ColorSchemeTypes {
        guard
            let modeRawValue: String = defaults.string(forKey: UserDefaultKeys.darkMode.rawValue),
            let colorSchemeType: ColorSchemeTypes = ColorSchemeTypes.allCases.first(where: { $0.rawValue == modeRawValue }) else { return .light }
        
        return colorSchemeType
    }
    
    // MARK: Tone
    func saveTone(_ value: String) {
        defaults.set(value, forKey: UserDefaultKeys.tone.rawValue)
    }
    
    func getTone() -> ToneTypes {
        guard
            let toneRawValue: String = defaults.string(forKey: UserDefaultKeys.tone.rawValue),
            let tone: ToneTypes = ToneTypes.allCases.first(where: {$0.rawValue == toneRawValue }) else { return .defaultTone }
        
        return tone
    }
    
    // MARK: Map Style
    func getMapStyle() -> MapStyleTypes {
        guard
            let mapStyleRawValue: String = defaults.string(forKey: UserDefaultKeys.mapStyle.rawValue),
            let mapStyle: MapStyleTypes = MapStyleTypes.allCases.first(where: {$0.rawValue == mapStyleRawValue }) else { return .standard }
        
        return mapStyle
    }
    
    func saveMapStyle(_ value: String) {
        defaults.set(value, forKey: UserDefaultKeys.mapStyle.rawValue)
    }
    
    // MARK: Map Style Button
    
    func getMapStyleButtonVisibility() -> Bool {
        if defaults.object(forKey: UserDefaultKeys.mapStyleButton.rawValue) == nil {
            return true
        } else {
            return defaults.bool(forKey: UserDefaultKeys.mapStyleButton.rawValue)
        }
    }
    
    func saveMapStyleButtonVisibility(_ value: Bool) {
        defaults.set(value, forKey: UserDefaultKeys.mapStyleButton.rawValue)
    }
    
    // MARK: - Tone Fade
    
    func getToneFade() -> Bool {
        if defaults.object(forKey: UserDefaultKeys.toneFade.rawValue) == nil {
            return false
        } else {
            return defaults.bool(forKey: UserDefaultKeys.toneFade.rawValue)
        }
    }
    
    func saveToneFade(_ value: Bool) {
        defaults.set(value, forKey: UserDefaultKeys.toneFade.rawValue)
    }
    
    func getToneFadeDuration() -> Double {
        let duration: Double = defaults.double(forKey: UserDefaultKeys.toneFadeDuration.rawValue)
        return duration == 0 ? 3 : duration
    }
    
    func saveFadeDuration(_ value: Double) {
        defaults.set(value, forKey: UserDefaultKeys.toneFadeDuration.rawValue)
    }
}

