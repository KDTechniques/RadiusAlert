//
//  UserDefaultsManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-19.
//

import Foundation

struct UserDefaultsManager {
    let defaults: UserDefaults = .init()
    
    private let darkModeKey: String = "darkMode"
    private let toneKey: String = "tone"
    
    
    func saveDarkMode(_ value: String) {
        defaults.set(value, forKey: darkModeKey)
    }
    
    func getDarkMode() -> ColorSchemeTypes {
        guard
            let modeRawValue: String = defaults.string(forKey: darkModeKey),
            let colorSchemeType: ColorSchemeTypes = ColorSchemeTypes.allCases.first(where: { $0.rawValue == modeRawValue }) else { return .light }
        
        return colorSchemeType
    }
    
    func saveTone(_ value: String) {
        defaults.set(value, forKey: toneKey)
    }
    
    func getTone() -> ToneTypes {
        guard
            let toneRawValue: String = defaults.string(forKey: toneKey),
            let tone: ToneTypes = ToneTypes.allCases.first(where: {$0.rawValue == toneRawValue }) else { return .defaultTone }
        
        return tone
    }
}
