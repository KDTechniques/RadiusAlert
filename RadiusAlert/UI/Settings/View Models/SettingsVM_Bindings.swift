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
        return Binding<Bool>(
            get: { self.showMapStyleButton },
            set: { self.setShowMapStyleButton($0) }
        )
    }
    
    func toneFadeToggleBinding() -> Binding<Bool> {
        return Binding<Bool>(
            get: { self.isEnabledToneFade },
            set: { newValue in withAnimation { self.setIsEnabledToneFade(newValue) } }
        )
    }
    
    func toneFadeDurationBinding() -> Binding<Double> {
        return Binding<Double>(
            get: { self.toneFadeDuration },
            set: { self.setToneFadeDuration($0) }
        )
    }
}
