//
//  AboutView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-12.
//

import SwiftUI

struct AboutView: View {
    @Environment(SettingsViewModel.self) var settingsVM
    
    // MARK: - BODY
    var body: some View {
        List {
            AboutBasicInfoView()
            AboutAppImprovementsView()
            AboutAppStoreRateView()
            AboutSomethingBoringView()
        }
        .navigationTitle(Text("About"))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { settingsVM.handleOnAppear() }
    }
}

// MARK: - PREVIEWS
#Preview("About") {
    NavigationStack {
        AboutView()
    }
    .previewModifier()
}

#Preview("Content") {
    ContentView()
        .previewModifier()
}
