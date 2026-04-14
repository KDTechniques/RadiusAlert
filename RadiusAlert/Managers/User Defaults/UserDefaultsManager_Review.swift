//
//  UserDefaultsManager_Review.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-04-12.
//

import Foundation

extension UserDefaultsManager {
    // MARK: Start Alert Count
    
    func getStartAlertCount() -> Int {
        return defaults.integer(forKey: UserDefaultKeys.startAlertCount.rawValue)
    }
    
    func saveStartAlertCount() {
        let startAlertCount: Int = getStartAlertCount()
        defaults.set(startAlertCount+1, forKey: UserDefaultKeys.startAlertCount.rawValue)
    }
    
    // MARK: - Did Ask For Review
    
    func getDidAskForReview() -> Bool {
        return defaults.bool(forKey: UserDefaultKeys.didAskForReview.rawValue)
    }
    
    func saveDidAskForReview() {
        defaults.set(true, forKey: UserDefaultKeys.didAskForReview.rawValue)
    }
}
