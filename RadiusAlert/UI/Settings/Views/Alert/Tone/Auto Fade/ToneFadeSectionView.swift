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
            Toggle("Alert Tone Fade", isOn: settingsVM.toneFadeToggleBinding())
            
            if settingsVM.isEnabledToneFade {
                VStack(alignment: .leading) {
                    Text(getFadeDurationText())
                    
                    Slider(value: settingsVM.toneFadeDurationBinding(), in: 5...10) { }
                    minimumValueLabel: {
                        Text("\(ToneValues.minDuration.int())s")
                    } maximumValueLabel: {
                        Text("\(ToneValues.maxDuration.int())s")
                    }
                }
            }
        } header: {
            Text("Select Alert Tone Fade Duration")
        } footer: {
            Text("Once you reach your destination radius, the alert tone will fade to 50% of your iPhone’s volume when Auto Fade is on.")
        }
    }
}

// MARK: - PREVIEWS
#Preview("ToneFadeSectionView") {
    List {
        ToneFadeSectionView()
    }
}

// MARK: - EXTENSIONS
extension ToneFadeSectionView {
    private func getFadeDurationText() -> String {
        let defaultText: String = "Duration: "
        let secondaryText: String = "\(Int(settingsVM.toneFadeDuration)) sec."
        
        return defaultText + secondaryText
    }
}
