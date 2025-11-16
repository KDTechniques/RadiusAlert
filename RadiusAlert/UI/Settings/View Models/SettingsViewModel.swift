//
//  SettingsViewModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-19.
//

import SwiftUI
import Combine

@Observable
final class SettingsViewModel {
    // MARK: - ASSIGNED PROPERTIES
    let mapStyleButtonTip: MapStyleButtonTipModel = .init()
    var cancellables: Set<AnyCancellable> = []
    
    // Managers/Services:
    let userDefaultsManager: UserDefaultsManager = .init()
    let alertManager: AlertManager = .shared
    
    // Appearance:
    private(set) var selectedColorScheme: ColorSchemeTypes? = .light { didSet { onColorSchemeChange() } }
    
    // Tone settings:
    private(set) var selectedTone: ToneTypes = .defaultTone { didSet { onToneChange() } }
    private(set) var isEnabledToneFade: Bool = false { didSet { onToneFadeToggleChange() } }
    private(set) var toneFadeDuration: Double = ToneValues.defaultDuration { didSet { toneFadeDuration$ = toneFadeDuration } }
    @ObservationIgnored @Published private(set) var toneFadeDuration$: Double = ToneValues.defaultDuration
    
    // Map settings:
    private(set) var selectedMapStyle: MapStyleTypes = .standard { didSet { onMapStyleChange(selectedMapStyle) } }
    private(set) var showMapStyleButton: Bool = true { didSet { onMapStyleButtonVisibilityChange(showMapStyleButton) } }
    
    // About:
    let settingsTip: SettingsTipModel = .init()
    
    // MARK: - INITIALIZER
    init() {
        initializeSettingsVM()
        toneFadeDurationSubscriber()
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
    
    func setIsEnabledToneFade(_ value: Bool) {
        isEnabledToneFade = value
    }
    
    func setToneFadeDuration(_ value: Double) {
        toneFadeDuration = value
    }
 
    // MARK: - PRIVATE FUNCTIONS
    private func initializeSettingsVM() {
        initializeFromUserDefaults()
    }
    
    private func initializeFromUserDefaults() {
        selectedColorScheme = userDefaultsManager.getDarkMode()
        selectedTone = userDefaultsManager.getTone()
        selectedMapStyle = userDefaultsManager.getMapStyle()
        showMapStyleButton = userDefaultsManager.getMapStyleButtonVisibility()
        isEnabledToneFade = userDefaultsManager.getToneFade()
        toneFadeDuration =  userDefaultsManager.getToneFadeDuration()
    }
    
    private func onColorSchemeChange() {
        guard let selectedColorScheme else { return }
        userDefaultsManager.saveDarkMode(selectedColorScheme.rawValue)
    }
}

