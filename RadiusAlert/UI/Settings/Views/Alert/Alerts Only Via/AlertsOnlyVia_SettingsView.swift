//
//  AlertsOnlyVia_SettingsView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-03-02.
//

import SwiftUI

struct AlertsOnlyVia_SettingsView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(SettingsViewModel.self) private var settingsVM
    
    // MARK: - BODY
    var body: some View {
        Picker("Alerts Only Via", selection: settingsVM.selectedAudioRouteOutputTypeBinding()) {
            ForEach(AudioRouteOutputTypes.allCases, id: \.self) {
                Text($0.label)
            }
        }
        .tint(.accentColor)
    }
}

// MARK: - PREVIEWS
#Preview("AlertsOnlyVia_SettingsView") {
    List {
        AlertsOnlyVia_SettingsView()
    }
    .previewModifier()
}
