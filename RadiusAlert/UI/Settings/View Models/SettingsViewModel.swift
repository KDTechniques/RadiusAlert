//
//  SettingsViewModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-19.
//

import SwiftUI

@Observable
final class SettingsViewModel {
    // MARK: - ASSIGNED PROEPRTIES
    let userDefaultsManager: UserDefaultsManager = .init()
    let alertManager: AlertManager = .shared
    private(set) var selectedColorScheme: ColorSchemeTypes? = .light { didSet { onColorSchemeChange() } }
    private(set) var selectedTone: ToneTypes = .defaultTone { didSet { onToneChange() } }
    private(set) var selectedMapStyle: MapStyleTypes = .standard { didSet { onMapStyleChange(selectedMapStyle) } }
    private(set) var showMapStyleButton: Bool = true { didSet { onMapStyleButtonVisibilityChange(showMapStyleButton) } }
    let mapStyleButtonTip: MapStyleButtonTipModel = .init()
    
    // MARK: - INITIALIZER
    init() {
        selectedColorScheme = userDefaultsManager.getDarkMode()
        selectedTone = userDefaultsManager.getTone()
        selectedMapStyle = userDefaultsManager.getMapStyle()
        showMapStyleButton = userDefaultsManager.getMapStyleButtonVisibility()
    }
    
    // MARK: - SETTERS
    func setColorScheme(_ scheme: ColorSchemeTypes?) {
        selectedColorScheme = scheme
    }
    
    func setTone(_ tone: ToneTypes) {
        selectedTone = tone
    }
    
    func setSelectedMapStyle(_ mapStyle: MapStyleTypes) {
        selectedMapStyle = mapStyle
    }
    
    func setShowMapStyleButton(_ boolean: Bool) {
        showMapStyleButton = boolean
    }
    
    // MARK: - PUBLIC FUNCTIONS
    func mapStyleButtonVisibilityBinding() -> Binding<Bool> {
        return Binding<Bool>(
            get: { [weak self] in
                self?.showMapStyleButton ?? true
            },
            set: { [weak self] newValue in
                self?.setShowMapStyleButton(newValue)
            }
        )
    }
    
    
    // MARK: - PRIVATE FUNCTIONS
    private func onColorSchemeChange() {
        guard let selectedColorScheme else { return }
        userDefaultsManager.saveDarkMode(selectedColorScheme.rawValue)
    }
    
    private func onToneChange() {
        userDefaultsManager.saveTone(selectedTone.rawValue)
    }
    
    private func invalidateMapStyleButtonTip() {
        mapStyleButtonTip.invalidate(reason: .actionPerformed)
    }
    
    private func onMapStyleChange(_ style: MapStyleTypes) {
        userDefaultsManager.saveMapStyle(style.rawValue)
        invalidateMapStyleButtonTip()
    }
    
    private func onMapStyleButtonVisibilityChange(_ boolean: Bool) {
        userDefaultsManager.saveMapStyleButtonVisibility(showMapStyleButton)
        MapStyleButtonTipModel.isMapStyleButtonVisible = boolean
    }
}
