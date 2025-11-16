//
//  SettingsNavigationLinkView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-16.
//

import SwiftUI

struct SettingsNavigationLinkView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(SettingsViewModel.self) private var settingsVM
    
    // MARK: - BODY
    var body: some View {
        navigationLink
            .popoverTip(settingsVM.navigationTitleTip)
            .tipImageStyle(.secondary)
    }
}

// MARK: - PREVIEWS
#Preview("SettingsNavigationLinkView") {
    NavigationStack {
        SettingsNavigationLinkView()
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension SettingsNavigationLinkView {
    @ViewBuilder
    private var navigationLink: some View {
        if #available(iOS 26.0, *) {
            NavigationLink {
                SettingsView()
            } label: {
                let size: CGFloat = 45
                Image(systemName: "gear")
                    .font(.title2)
                    .frame(width: size, height: size)
            }
            .buttonStyle(.plain)
            .glassEffect(.regular.interactive(), in: .circle)
        } else { // iOS 18.6
            NavigationLink {
                SettingsView()
            } label: {
                Text("Settings")
            }
        }
    }
}
