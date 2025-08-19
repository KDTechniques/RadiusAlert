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
    
    
    func saveDarkMode(_ value: String) {
        defaults.set(value, forKey: darkModeKey)
    }
    
    func getDarkMode() -> ColorSchemeTypes {
        guard
            let string: String = defaults.string(forKey: darkModeKey),
            let colorSchemeType: ColorSchemeTypes = ColorSchemeTypes.allCases.first(where: { $0.rawValue == string }) else { return .light }
        
        return colorSchemeType
    }
}
