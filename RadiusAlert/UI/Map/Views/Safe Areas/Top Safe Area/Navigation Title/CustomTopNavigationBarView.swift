//
//  CustomTopNavigationBarView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import SwiftUI

struct CustomTopNavigationBarView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    @Environment(SettingsViewModel.self) private var settingsVM
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 5) {
            titleText
            LogoView(color: mapVM.getNavigationTitleIconColor(), size: 35)
            Spacer()
            settingsNavigationLink
            debug
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

// MARK: - PREVIEWS
#Preview("CustomTopNavigationBarView") {
    NavigationStack {
        CustomTopNavigationBarView()
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension CustomTopNavigationBarView {
    private var titleText: some View {
        Text("Radius Alert")
            .tint(.primary)
            .font(.largeTitle)
            .fontWeight(.bold)
    }
    
    @ViewBuilder
    private var debug: some View  {
#if DEBUG
        DebugView()
#endif
    }
    
    private var settingsNavigationLink: some View {
        NavigationLink {
            SettingsView()
        } label: {
            Text("Settings")
        }
        .popoverTip(settingsVM.navigationTitleTip)
        .tipImageStyle(.secondary)
    }
}
