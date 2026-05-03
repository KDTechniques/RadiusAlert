//
//  About.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-13.
//

import Foundation

// MARK: ABOUT

extension SettingsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    /// Handles the About screen's onAppear lifecycle event.
    /// - Note: Invalidates the settings tip to reflect that the related action was performed.
    func handleOnAppear() {
        settingsTip.invalidate(reason: .actionPerformed)
    }
}
