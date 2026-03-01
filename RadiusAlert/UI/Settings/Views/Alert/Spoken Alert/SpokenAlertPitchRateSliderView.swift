//
//  SpokenAlertPitchRateSliderView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-17.
//

import SwiftUI

struct SpokenAlertPitchRateSliderView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(SettingsViewModel.self) private var settingsVM
    
    // MARK: - ASSIGNED PROPERTIES
    let values = SpokenAlertValues.self
    
    //MARK: - BODY
    var body: some View {
        Section {
            Slider(
                value: settingsVM.pitchRateBinding(),
                in: values.pitchRateRange,
                step: values.step
            ) {}
            minimumValueLabel: {
                Image(systemName: "wave.3.right", variableValue: 0.1)
            } maximumValueLabel: {
                Image(systemName: "wave.3.right", variableValue: 1.0)
            } onEditingChanged: { settingsVM.onSpokenAlertSliderEditingChange($0) }
                .foregroundStyle(.secondary)
        } header: {
            Text("Pitch")
        }
    }
}

// MARK: - PREVIEWS
#Preview("SpokenAlertPitchRateSliderView") {
    List {
        SpokenAlertPitchRateSliderView()
    }
    .previewModifier()
}
