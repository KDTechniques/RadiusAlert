//
//  AutoAlertStopSettingsView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-03-01.
//

import SwiftUI

struct AutoAlertStopSettingsView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(SettingsViewModel.self) private var settingsVM
    
    // MARK: - BODY
    var body: some View {
        List {
            Section {
                toggle
                slider
            } header: {
                header
            } footer: {
                footer
            }
        }
        .navigationTitle(.init("Auto Alert Stop"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - PREVIEWS
#Preview("AutoAlertStopSettingsView") {
    NavigationStack {
        AutoAlertStopSettingsView()
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension AutoAlertStopSettingsView {
    private var header: some View {
        Text("Select Auto Alert Stop Duration")
    }
    
    private var toggle: some View {
        Toggle("Auto Alert Stop", isOn: settingsVM.autoAlertStopToggleBinding())
    }
    
    @ViewBuilder
    private var slider: some View {
        if settingsVM.isEnableAutoAlertStop {
            VStack(alignment: .leading) {
                Text(settingsVM.getAutoAlertStopDurationString())
                
                Slider(value: settingsVM.autoAlertStopDurationBinding(),
                       in: AlertValues.autoAlertStopMinDuration...AlertValues.autoAlertStopMaxDuration,
                       step: 1
                ) { }
                minimumValueLabel: {
                    Text("\(AlertValues.autoAlertStopMinDuration.int())s")
                } maximumValueLabel: {
                    Text("\(AlertValues.autoAlertStopMaxDuration.int())s")
                }
            }
        }
    }
    
    private var footer: some View {
        Text("Alerts will automatically dismiss after the selected duration if you don’t interact with them.\n\nEx: if you’re in a crowded bus and need to get off quickly, the alert will stop on its own without you taking your phone out.")
    }
}
