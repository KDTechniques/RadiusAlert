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
    
    func toneFadeToggleBinding() -> Binding<Bool> {
        return Binding<Bool>(
            get: { [weak self] in
                self?.isEnabledToneFade ?? false
            },
            set: { [weak self] newValue in
                withAnimation {
                    self?.setIsEnabledToneFade(newValue)
                }
            }
        )
    }
    
    func toneFadeDurationBinding() -> Binding<Double> {
        return Binding<Double>(
            get: { [weak self] in
                self?.toneFadeDuration ?? 0
            },
            set: { [weak self] newValue in
                self?.setToneFadeDuration(newValue)
            }
        )
    }
    
    func setToneVolumeToFade() {
        guard isEnabledToneFade else { return }
        Task {
            try? await Task.sleep(nanoseconds: .seconds(toneFadeDuration))
            alertManager.setToneVolume(0.5)
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func initializeSettingsVM() {
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
    
    private func toneFadeDurationSubscriber() {
        $toneFadeDuration$
            .removeDuplicates()
            .debounce(for: .nanoseconds(1_000_000_000), scheduler: DispatchQueue.main)
            .sink { [weak self] value in
                self?.userDefaultsManager.saveFadeDuration(value)
            }
            .store(in: &cancellables)
    }
}
