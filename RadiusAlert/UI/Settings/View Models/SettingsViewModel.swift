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
    // MARK: - ASSIGNED PROEPRTIES
    let userDefaultsManager: UserDefaultsManager = .init()
    let alertManager: AlertManager = .shared
    private var cancellables: Set<AnyCancellable> = []
    private(set) var selectedColorScheme: ColorSchemeTypes? = .light { didSet { onColorSchemeChange() } }
    private(set) var selectedTone: ToneTypes = .defaultTone { didSet { onToneChange() } }
    private(set) var toneFadeDuration: Double = ToneValues.defaultDuration { didSet { toneFadeDuration$ = toneFadeDuration } }
    @ObservationIgnored @Published private var toneFadeDuration$: Double = ToneValues.defaultDuration
    private(set) var isEnabledToneFade: Bool = false { didSet { onToneFadeToggleChange() } }
    private(set) var selectedMapStyle: MapStyleTypes = .standard { didSet { onMapStyleChange(selectedMapStyle) } }
    private(set) var showMapStyleButton: Bool = true { didSet { onMapStyleButtonVisibilityChange(showMapStyleButton) } }
    let mapStyleButtonTip: MapStyleButtonTipModel = .init()
    
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
    
    // MARK: - BINDINGS
    func mapStyleButtonVisibilityBinding() -> Binding<Bool> {
        return Binding<Bool>(
            get: { self.showMapStyleButton },
            set: { self.setShowMapStyleButton($0) }
        )
    }
    
    func toneFadeToggleBinding() -> Binding<Bool> {
        return Binding<Bool>(
            get: { self.isEnabledToneFade },
            set: { newValue in
                withAnimation {
                    self.setIsEnabledToneFade(newValue)
                }
            }
        )
    }
    
    func toneFadeDurationBinding() -> Binding<Double> {
        return Binding<Double>(
            get: { self.toneFadeDuration },
            set: { self.setToneFadeDuration($0) }
        )
    }
    
    // MARK: - SUBSCRIBERS
    private func toneFadeDurationSubscriber() {
        $toneFadeDuration$
            .removeDuplicates()
            .debounce(for: .nanoseconds(1_000_000_000), scheduler: DispatchQueue.main)
            .sink { self.userDefaultsManager.saveFadeDuration($0) }
            .store(in: &cancellables)
    }
    
    // MARK: - PUBLIC FUNCTIONS
    
    func setToneVolumeToFade() {
        guard isEnabledToneFade else { return }
        
        Task {
            do {
                try await Task.sleep(nanoseconds: .seconds(toneFadeDuration))
                alertManager.setAbsoluteToneVolume(0.5)
            }
        }
    }
    
    func getToneFadeDurationString() -> String {
        let defaultText: String = "Duration: "
        let secondaryText: String = "\(toneFadeDuration.int()) sec."
        
        return defaultText + secondaryText
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
    
    private func onToneChange() {
        userDefaultsManager.saveTone(selectedTone.rawValue)
    }
    
    private func onToneFadeToggleChange() {
        userDefaultsManager.saveToneFade(isEnabledToneFade)
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
