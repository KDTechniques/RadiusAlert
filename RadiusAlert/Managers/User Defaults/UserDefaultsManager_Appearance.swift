//
//  UserDefaultsManager_Appearance.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-28.
//

import Foundation

extension UserDefaultsManager {
    // MARK: - Dark Mode
    
    func saveDarkMode(_ value: String) {
        defaults.set(value, forKey: UserDefaultKeys.darkMode.rawValue)
    }
    
    func getDarkMode() -> ColorSchemeTypes {
        guard
            let modeRawValue: String = defaults.string(forKey: UserDefaultKeys.darkMode.rawValue),
            let colorSchemeType: ColorSchemeTypes = ColorSchemeTypes.allCases.first(where: { $0.rawValue == modeRawValue }) else { return .system }
        
        return colorSchemeType
    }
}
