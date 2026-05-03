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
    /// Tone Fade
    private(set) var isEnabledToneFade: Bool = true { didSet { onToneFadeToggleChange() } }
    private(set) var toneFadeDuration: Double = ToneValues.toneFadeDefaultDuration { didSet { toneFadeDuration$ = toneFadeDuration } }
    @ObservationIgnored @Published private(set) var toneFadeDuration$: Double = ToneValues.toneFadeDefaultDuration
    /// Auto Alert Stop
    private(set) var isEnableAutoAlertStop: Bool = true { didSet { onAutoAlertStopToggleChange() } }
    private(set) var autoAlertStopDuration: Double = AlertValues.autoAlertStopDefaultDuration { didSet { autoAlertStopDuration$ = autoAlertStopDuration } }
    @ObservationIgnored @Published private(set) var autoAlertStopDuration$: Double = AlertValues.autoAlertStopDefaultDuration
    /// Audio Route Output
    private(set) var currentAudioRouteOutputType: AudioRouteOutputTypes = .allDevice
    private(set) var selectedAudioRouteOutputType: AudioRouteOutputTypes = .allDevice { didSet { onAudioRouteOutputChange() } }
    
    // Text to Speech Spoken Alert:
    private(set) var voiceNamesArray: [String] = []
    private(set) var spokenAlert: SpokenAlertModel = .initialValues { didSet { spokenAlert$ = spokenAlert } }
    @ObservationIgnored @Published private var spokenAlert$: SpokenAlertModel = .initialValues
    
    // Map settings:
    private(set) var selectedMapStyle: MapStyleTypes = .standard { didSet { onMapStyleChange(selectedMapStyle) } }
    private(set) var showMapStyleButton: Bool = false { didSet { onMapStyleButtonVisibilityChange(showMapStyleButton) } }
    
    // About:
    let settingsTip: SettingsTipModel = .init()
    
    // MARK: - INITIALIZER
    init() {
        initializeSettingsVM()
        spokenAlertValuesSubscriber()
        toneFadeDurationSubscriber()
        autoAlertStopDurationSubscriber()
        audioRouteChangeObserver()
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
        spokenAlert.userName = value
    }
    
    func setSelectedVoiceName(_ value: String) {
        spokenAlert.voice = value
    }
    
    func setSpeakingRate(_ value: CGFloat) {
        spokenAlert.speakingRate = value
    }
    
    func setPitchRate(_ value: CGFloat) {
        spokenAlert.pitchRate = value
    }
    
    func SetIsOnSpokenAlert(_ value: Bool) {
        spokenAlert.isOnSpokenAlert = value
    }
    
    func setAutoAlertStop(_ isEnabled: Bool) {
        isEnableAutoAlertStop = isEnabled
    }
    
    func setAutoAlertStopDuration(_ duration: Double) {
        autoAlertStopDuration = duration
    }
    
    func setCurrentAudioRouteOutputType(_ type: AudioRouteOutputTypes) {
        currentAudioRouteOutputType = type
    }
    
    func setSelectedAudioRouteOutputType(_ type: AudioRouteOutputTypes) {
        selectedAudioRouteOutputType = type
    }
    
    // MARK: - PRIVATE FUNCTIONS
    /// Bootstraps the Settings VM by loading persisted values and syncing the current audio route.
    private func initializeSettingsVM() {
        // Load all persisted settings into in-memory state (may trigger didSet side-effects).
        initializeFromUserDefaults()
        // Query the system for the current audio route and mirror it to our state.
        setCurrentAudioRouteOutputType(getCurrentAudioRouteOutputType())
    }
    
    /// Observes changes to `spokenAlert`, debounces rapid edits, and persists to UserDefaults.
    private func spokenAlertValuesSubscriber() {
        $spokenAlert$
        // Debounce to avoid frequent writes while the user types/slides (1s).
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
        // Only proceed when the value actually changes.
            .removeDuplicates(by: { $0 == $1 })
            .sink { [weak self] in
                guard let self else { return }
                // Persist the latest spoken alert configuration.
                userDefaultsManager.saveSpokenAlert($0)
            }
            .store(in: &cancellables)
    }
    
    /// Reads all settings from UserDefaults and assigns them to the in-memory properties.
    private func initializeFromUserDefaults() {
        // Appearance & alerts configuration loaded from persistence.
        selectedColorScheme = userDefaultsManager.getDarkMode()
        selectedTone = userDefaultsManager.getTone()
        selectedMapStyle = userDefaultsManager.getMapStyle()
        showMapStyleButton = userDefaultsManager.getMapStyleButtonVisibility()
        isEnabledToneFade = userDefaultsManager.getToneFade()
        toneFadeDuration =  userDefaultsManager.getToneFadeDuration()
        spokenAlert = userDefaultsManager.getSpokenAlert()
        isEnableAutoAlertStop = userDefaultsManager.getAutoAlertStop()
        autoAlertStopDuration = userDefaultsManager.getAutoAlertStopDuration()
        selectedAudioRouteOutputType = userDefaultsManager.getAudioRouteOutputType()
    }
    
    /// Persists the selected color scheme whenever it changes.
    private func onColorSchemeChange() {
        guard let selectedColorScheme else { return }
        userDefaultsManager.saveDarkMode(selectedColorScheme.rawValue)
    }
}

