//
//  SettingsVM_Subscribers.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-02.
//

import Foundation

extension SettingsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    /// Subscribes to changes in the tone fade duration property, debounces updates, and saves changes to user defaults.
    func toneFadeDurationSubscriber() {
        $toneFadeDuration$
            .removeDuplicates()
            .debounce(for: .nanoseconds(1_000_000_000), scheduler: DispatchQueue.main)
            .sink { self.userDefaultsManager.saveFadeDuration($0) }
            .store(in: &cancellables)
    }
}
