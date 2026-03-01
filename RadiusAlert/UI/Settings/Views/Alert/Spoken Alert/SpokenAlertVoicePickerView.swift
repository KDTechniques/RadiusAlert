//
//  SpokenAlertVoicePickerView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-17.
//

import SwiftUI

struct SpokenAlertVoicePickerView: View {
    // MARK: INJECTED PROPERTIES
    @Environment(SettingsViewModel.self) private var settingsVM
    
    // MARK: - BODY
    var body: some View {
        Picker("Voice", selection: settingsVM.selectedVoiceNameBinding()) {
            ForEach(settingsVM.voiceNamesArray, id: \.self) {
                Text($0)
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("SpokenAlertVoicePickerView") {
    List {
        SpokenAlertVoicePickerView()
    }
    .previewModifier()
}
