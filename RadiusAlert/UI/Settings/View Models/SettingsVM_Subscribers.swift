//
//  SettingsVM_Subscribers.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-02.
//

import Foundation

// MARK: SUBSCRIBERS

extension SettingsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    /// Subscribes to changes in the tone fade duration property, debounces updates, and saves changes to user defaults.
    func toneFadeDurationSubscriber() {
        $toneFadeDuration$
        // Ignore repeated values to prevent unnecessary persistence.
            .removeDuplicates()
        // Debounce rapid slider/typing input; persist only after 1s of inactivity.
            .debounce(for: .seconds(1.0), scheduler: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else { return }
                // Save the updated fade duration to UserDefaults.
                userDefaultsManager.saveFadeDuration($0)
            }
            .store(in: &cancellables)
    }
    
    /// Subscribes to changes in the auto alert stop duration property, debounces updates, and saves changes to user defaults.
    func autoAlertStopDurationSubscriber() {
        $autoAlertStopDuration$
        // Ignore identical values to avoid redundant writes.
            .removeDuplicates()
        // Debounce to batch quick changes; write after 1s of no updates.
            .debounce(for: .seconds(1.0), scheduler: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else { return }
                // Persist the latest auto-stop duration to UserDefaults.
                userDefaultsManager.saveAutoAlertStopDuration($0)
            }
            .store(in: &cancellables)
    }
}

