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
    let alertManager: AlertManager = .shared
    private(set) var selectedColorScheme: ColorSchemeTypes? = .light { didSet { onColorSchemeChange() } }
    private(set) var selectedTone: ToneTypes = .defaultTone { didSet { onToneChange() } }
    
    // MARK: - INITIALIZER
    init() {
        selectedColorScheme = userDefaultsManager.getDarkMode()
        selectedTone = userDefaultsManager.getTone()
    }
    
    // MARK: - SETTERS
    func setColorScheme(_ scheme: ColorSchemeTypes?) {
        selectedColorScheme = scheme
    }
    
    func setTone(_ tone: ToneTypes) {
        selectedTone = tone
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func onColorSchemeChange() {
        guard let selectedColorScheme else { return }
        userDefaultsManager.saveDarkMode(selectedColorScheme.rawValue)
    }
    
    private func onToneChange() {
        userDefaultsManager.saveTone(selectedTone.rawValue)
    }
}
