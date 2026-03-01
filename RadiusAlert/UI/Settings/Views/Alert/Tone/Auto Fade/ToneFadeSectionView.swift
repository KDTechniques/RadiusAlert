//
//  ToneFadeSectionView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-10-28.
//

import SwiftUI

struct ToneFadeSectionView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(SettingsViewModel.self) private var settingsVM
    
    // MARK: - BODY
    var body: some View {
        Section {
            toggle
            slider
        } header: {
            header
        } footer: {
            footer
        }
    }
}

// MARK: - PREVIEWS
#Preview("ToneFadeSectionView") {
    List {
        ToneFadeSectionView()
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension ToneFadeSectionView {
    private var header: some View {
        Text("Select Alert Tone Fade Duration")
    }
    
    private var toggle: some View {
        Toggle("Auto Alert Tone Fade", isOn: settingsVM.toneFadeToggleBinding())
    }
    
    @ViewBuilder
    private var slider: some View {
        if settingsVM.isEnabledToneFade {
            VStack(alignment: .leading) {
                Text(settingsVM.getToneFadeDurationString())
                
                Slider(
                    value: settingsVM.toneFadeDurationBinding(),
                    in: ToneValues.toneFadeMinDuration...ToneValues.toneFadeMaxDuration,
                    step: 1
                ) { }
                minimumValueLabel: {
                    Text("\(ToneValues.toneFadeMinDuration.int())s")
                } maximumValueLabel: {
                    Text("\(ToneValues.toneFadeMaxDuration.int())s")
                }
            }
        }
    }
    
    private var footer: some View {
        Text("Once you reach your destination radius, the alert tone will fade to 50% of your iPhone’s volume when Auto Alert Tone Fade is on.")
    }
}
