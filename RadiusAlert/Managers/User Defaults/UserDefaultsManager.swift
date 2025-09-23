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
    private let mapStyleKey: String = "mapStyle"
    private let mapStyleButtonVisibilityKey: String = "mapStyleButton"
    
    // MARK: Dark Mode
    func saveDarkMode(_ value: String) {
        defaults.set(value, forKey: darkModeKey)
    }
    
    func getDarkMode() -> ColorSchemeTypes {
        guard
            let modeRawValue: String = defaults.string(forKey: darkModeKey),
            let colorSchemeType: ColorSchemeTypes = ColorSchemeTypes.allCases.first(where: { $0.rawValue == modeRawValue }) else { return .light }
        
        return colorSchemeType
    }
    
    // MARK: Tone
    func saveTone(_ value: String) {
        defaults.set(value, forKey: toneKey)
    }
    
    func getTone() -> ToneTypes {
        guard
            let toneRawValue: String = defaults.string(forKey: toneKey),
            let tone: ToneTypes = ToneTypes.allCases.first(where: {$0.rawValue == toneRawValue }) else { return .defaultTone }
        
        return tone
    }
    
    // MARK: Map Style
    func getMapStyle() -> MapStyleTypes {
        guard
            let mapStyleRawValue: String = defaults.string(forKey: mapStyleKey),
            let mapStyle: MapStyleTypes = MapStyleTypes.allCases.first(where: {$0.rawValue == mapStyleRawValue }) else { return .standard }
        
        return mapStyle
    }
    
    func saveMapStyle(_ value: String) {
        defaults.set(value, forKey: mapStyleKey)
    }
    
    // MARK: Map Style Button
    
    func getMapStyleButtonVisibility() -> Bool {
        if defaults.object(forKey: mapStyleButtonVisibilityKey) == nil {
            return true
        } else {
            return defaults.bool(forKey: mapStyleButtonVisibilityKey)
        }
    }
    
    func saveMapStyleButtonVisibility(_ value: Bool) {
        defaults.set(value, forKey: mapStyleButtonVisibilityKey)
    }
}
