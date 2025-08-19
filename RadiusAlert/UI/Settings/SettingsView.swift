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
            appearance
            alert
            mapStyle
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

// MARK: - EXTENSIONS
extension SettingsView {
    private var appearance: some View {
        NavigationLink {
            AppearanceListSectionView()
        } label: {
            Text("Appearance")
        }
    }
    
    private var alert: some View {
        NavigationLink {
            ToneNavigationLinkView()
        } label: {
            Text("Alerts")
        }
    }
    
    private var mapStyle: some View {
        NavigationLink {
            
        } label: {
            Text("Map Style")
        }
    }
}
