//
//  SettingsView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-18.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - BODY
    var body: some View {
        List {
            AppearanceListSectionView()
            AlertsListSectionView()
            MapStyleListSectionView()
        }
        .navigationTitle(Text("Settings"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - PREVIEWS
#Preview("Settings") {
    NavigationStack {
        SettingsView()
    }
    .previewModifier()
}

#Preview("About") {
    NavigationStack {
        AboutView()
    }
    .previewModifier()
}
