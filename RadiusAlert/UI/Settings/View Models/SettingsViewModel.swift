//
//  SettingsViewModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-19.
//

import Foundation

@Observable
final class SettingsViewModel {
    // MARK: - ASSIGNED PROEPRTIES
    let userDefaultsManager: UserDefaultsManager = .init()
    private(set) var selectedColorScheme: ColorSchemeTypes? = .light { didSet { onColorSchemeChange() } }
    
    // MARK: - INITIALIZER
    init() {
        selectedColorScheme = userDefaultsManager.getDarkMode()
    }
    
    // MARK: - SETTERS
    func setColorScheme(_ scheme: ColorSchemeTypes?) {
        selectedColorScheme = scheme
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func onColorSchemeChange() {
        guard let selectedColorScheme else { return }
        userDefaultsManager.saveDarkMode(selectedColorScheme.rawValue)
    }
}
