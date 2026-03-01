//
//  SpokenAlertSettingsView.swift
//  RadiusAlerts
//
//  Created by Kavinda Dilshan on 2025-11-16.
//

import SwiftUI

struct SpokenAlertSettingsView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(SettingsViewModel.self) private var settingsVM
    
    // MARK: - BODY
    var body: some View {
        List {
            SpokenAlertToggleView()
            SpokenAlertUserNameTextFieldView()
            SpokenAlertVoicePickerView()
            SpokenAlertSpeakingRateSliderView()
            SpokenAlertPitchRateSliderView()
        }
        .navigationTitle(Text("Spoken Alert"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { toolbar }
        .task { await settingsVM.getNSetVoiceNamesArray() }
        .onChange(of: settingsVM.spokenAlert.voice) { _, _ in
            Task { await settingsVM.spokenAlertSpeakAction() }
        }
        .onDisappear { settingsVM.onSpokenAlertViewDisappear() }
    }
}

// MARK: - PREVIEWS
#Preview("SpokenAlertView") {
    NavigationStack {
        SpokenAlertSettingsView()
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension SpokenAlertSettingsView {
    private var toolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                Task { await settingsVM.spokenAlertSpeakAction() }
            } label: {
                Image(systemName: "play.fill")
            }
        }
    }
}
