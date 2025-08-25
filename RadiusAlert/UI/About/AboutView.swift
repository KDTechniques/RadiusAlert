//
//  AboutView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-12.
//

import SwiftUI

struct AboutView: View {
    // MARK: - BODY
    var body: some View {
        List {
            AboutBasicInfoView()
            AboutAppImprovementsView()
            AboutAppStoreRateView()
            AboutSomethingBoringView()
        }
        .toolbar { settingsNavigationLink }
        .navigationTitle(Text("About"))
        .navigationBarTitleDisplayMode(.inline)
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

// MARK: - EXTENSIONS
extension AboutView {
    private var settingsNavigationLink: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink {
                SettingsView()
            } label: {
                Image(systemName: "gear")
            }
        }
    }
}
