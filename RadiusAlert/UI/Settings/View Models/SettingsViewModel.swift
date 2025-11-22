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
    let textToSpeechManager: TextToSpeechManager = .shared
    
    // Appearance:
    private(set) var selectedColorScheme: ColorSchemeTypes? = .system { didSet { onColorSchemeChange() } }
    
    // Tone settings:
    private(set) var selectedTone: ToneTypes = .defaultTone { didSet { onToneChange() } }
    private(set) var isEnabledToneFade: Bool = true { didSet { onToneFadeToggleChange() } }
    private(set) var toneFadeDuration: Double = ToneValues.defaultDuration { didSet { toneFadeDuration$ = toneFadeDuration } }
    @ObservationIgnored @Published private(set) var toneFadeDuration$: Double = ToneValues.defaultDuration
    
    // Text to Speech Spoken Alert:
    private(set) var voiceNamesArray: [String] = []
    private(set) var spokenAlertValues: SpokenAlertModel = .initialValues { didSet { spokenAlertValues$ = spokenAlertValues } }
    @ObservationIgnored @Published private var spokenAlertValues$: SpokenAlertModel = .initialValues
    
    // Map settings:
    private(set) var selectedMapStyle: MapStyleTypes = .standard { didSet { onMapStyleChange(selectedMapStyle) } }
    private(set) var showMapStyleButton: Bool = true { didSet { onMapStyleButtonVisibilityChange(showMapStyleButton) } }
    
    // About:
    let settingsTip: SettingsTipModel = .init()
    
    // MARK: - INITIALIZER
    init() {
        spokenAlertValuesSubscriber()
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
    
    func setVoiceNamesArray(_ value: [String]) {
        voiceNamesArray = value
    }
    
    func setSpokenUserNameTextFieldText(_ value: String) {
        spokenAlertValues.userName = value
    }
    
    func setSelectedVoiceName(_ value: String) {
        spokenAlertValues.voice = value
    }
    
    func setSpeakingRate(_ value: CGFloat) {
        spokenAlertValues.speakingRate = value
    }
    
    func setPitchRate(_ value: CGFloat) {
        spokenAlertValues.pitchRate = value
    }
    
    func SetIsOnSpokenAlert(_ value: Bool) {
        spokenAlertValues.isOnSpokenAlert = value
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func initializeSettingsVM() {
        initializeFromUserDefaults()
    }
    
    private func spokenAlertValuesSubscriber() {
        $spokenAlertValues$
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .removeDuplicates(by: { $0 == $1 })
            .sink { self.userDefaultsManager.saveSpokenAlert($0) }
            .store(in: &cancellables)
    }
    
    private func initializeFromUserDefaults() {
        selectedColorScheme = userDefaultsManager.getDarkMode()
        selectedTone = userDefaultsManager.getTone()
        selectedMapStyle = userDefaultsManager.getMapStyle()
        showMapStyleButton = userDefaultsManager.getMapStyleButtonVisibility()
        isEnabledToneFade = userDefaultsManager.getToneFade()
        toneFadeDuration =  userDefaultsManager.getToneFadeDuration()
        spokenAlertValues = userDefaultsManager.getSpokenAlert()
    }
    
    private func onColorSchemeChange() {
        guard let selectedColorScheme else { return }
        userDefaultsManager.saveDarkMode(selectedColorScheme.rawValue)
    }
}
