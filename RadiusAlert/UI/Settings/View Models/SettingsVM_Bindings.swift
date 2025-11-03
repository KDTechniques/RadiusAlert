//
//  SettingsVM_Bindings.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-02.
//

import SwiftUI

extension SettingsViewModel {
    // MARK: - PUBLIC FUNCTIONS
    
    func mapStyleButtonVisibilityBinding() -> Binding<Bool> {
        return .init(get: { self.showMapStyleButton }, set: setShowMapStyleButton)
    }
    
    func toneFadeToggleBinding() -> Binding<Bool> {
        return .init(get: { self.isEnabledToneFade }, set: withAnimation { setIsEnabledToneFade })
    }
    
    func toneFadeDurationBinding() -> Binding<Double> {
        return .init(get: { self.toneFadeDuration }, set: setToneFadeDuration)
    }
}
