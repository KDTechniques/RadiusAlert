//
//  SpokenAlertUserNameTextFieldView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-17.
//

import SwiftUI

struct SpokenAlertUserNameTextFieldView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(SettingsViewModel.self) private var settingsVM
    
    // MARK: - BODY
    var body: some View {
        Section {
            TextField("Your Name", text: settingsVM.spokenUserNameTextFieldTextBinding(), prompt: Text("Optional"))
                .limitInputLength(settingsVM.spokenUserNameTextFieldTextBinding(), to: SpokenAlertValues.maxUserNameCharacters)
        } header: {
            Text("Your Name")
        } footer: {
            Text("Your name is used to personalize the spoken alert.")
        }
    }
}

// MARK: - PREVIEWS
#Preview("SpokenAlertUserNameTextFieldView") {
    List {
        SpokenAlertUserNameTextFieldView()
    }
    .previewModifier()
}
