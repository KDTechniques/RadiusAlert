//
//  UserDefaultsManager_Search.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-28.
//

import Foundation

extension UserDefaultsManager {
    // MARK: - Recents
    
    func getRecents() -> [RecentsModel] {
        guard let data: Data = defaults.data(forKey: UserDefaultKeys.recents.rawValue) else { return [] }
        
        do {
            let recentsArray: [RecentsModel] = try JSONDecoder().decode([RecentsModel].self, from: data)
            return recentsArray
        } catch let error {
            print("❌: Error getting recents from user defaults. \(error.localizedDescription)")
            return []
        }
    }
    
    func saveRecents(_ value: [RecentsModel]) {
        do {
            let data: Data = try JSONEncoder().encode(value)
            defaults.set(data, forKey: UserDefaultKeys.recents.rawValue)
        } catch let error {
            print("❌: Error saving recents to user defaults. \(error.localizedDescription)")
        }
    }
}
