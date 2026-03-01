//
//  SpokenAlertSpeakingRateSliderView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-17.
//

import SwiftUI

struct SpokenAlertSpeakingRateSliderView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(SettingsViewModel.self) private var settingsVM
    
    // MARK: - ASSIGNED PROPERTIES
    let values = SpokenAlertValues.self
    
    // MARK: - BODY
    var body: some View {
        Section {
            Slider(
                value: settingsVM.speakingRateBinding(),
                in: values.speakingRateRange,
                step: values.step
            ) {}
            minimumValueLabel: {
                Image(systemName: "tortoise.fill")
            } maximumValueLabel: {
                Image(systemName: "hare.fill")
            } onEditingChanged: { settingsVM.onSpokenAlertSliderEditingChange($0) }
                .foregroundStyle(.secondary)
        } header: {
            Text("Speaking Rate")
        }
    }
}

//MARK: - PREVIEWS
#Preview("SpokenAlertSpeakingRateSliderView") {
    List {
        SpokenAlertSpeakingRateSliderView()
    } .previewModifier()
}
