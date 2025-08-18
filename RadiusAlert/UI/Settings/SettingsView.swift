//
//  SettingsView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-18.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// MARK: - PREVIEWS
#Preview("Settings") {
    SettingsView()
        .previewModifier()
}

#Preview("About") {
    NavigationStack {
        AboutView()
    }
    .previewModifier()
}
