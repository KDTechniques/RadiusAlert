//
//  UserDefaultsManager.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-19.
//

import Foundation

struct UserDefaultsManager {
    let defaults: UserDefaults = .init()
    
    /// Clears all values stored in User Defaults.
    static func clearAllUserDefaults() {
        guard let bundleID = Bundle.main.bundleIdentifier else { return }
        UserDefaults.standard.removePersistentDomain(forName: bundleID)
    }
}
