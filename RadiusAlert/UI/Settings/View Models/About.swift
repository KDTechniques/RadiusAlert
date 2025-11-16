//
//  About.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-13.
//

import Foundation

extension SettingsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    func handleOnAppear() {
        settingsTip.invalidate(reason: .actionPerformed)
    }
}
