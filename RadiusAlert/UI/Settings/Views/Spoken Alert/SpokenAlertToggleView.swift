//
//  SpokenAlertToggleView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-17.
//

import SwiftUI

struct SpokenAlertToggleView: View {
    // MARK: - INEJCTED PROPERTIES
    @Environment(SettingsViewModel.self) private var settingsVM
    
    // MARK: - BODY
    var body: some View {
        Section {
            Toggle("Spoken Alert", isOn: settingsVM.isOnSpokenAlertBinding())
        } footer: {
            Text("Spoken Alert uses voice notifications to announce when you are close to a set location.")
        }
    }
}

// MARK: - PREVIEWS
#Preview("SpokenAlertToggleView") {
    List {
        SpokenAlertToggleView()
    }
    .previewModifier()
}
