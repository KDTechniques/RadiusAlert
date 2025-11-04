//
//  MapStyleButtonView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-08-03.
//

import SwiftUI

struct MapStyleButtonView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(SettingsViewModel.self) private var settingsVM
    
    // MARK: - BODY
    var body: some View {
        if settingsVM.showMapStyleButton {
            ButtonView()
        }
    }
}

// MARK: - PREVIEWS
#Preview("MapStyleButtonView") {
    ButtonView()
        .previewModifier()
}

#Preview("ContentView") {
    ContentView()
        .previewModifier()
}

//  MARK: - SUB VIEWS
fileprivate struct ButtonView: View {
    @Environment(MapViewModel.self) private var mapVM
    @Environment(SettingsViewModel.self) private var settingsVM
    
    var body: some View {
        if #available(iOS 26.0, *) {
            glassButton
        } else {
            nonGlassButton
        }
    }
}

// MARK: - EXTENSIONS
extension ButtonView {
    private var nonGlassButton: some View {
        Button {
            mapVM.setNextMapStyle()
        } label: {
            Image(systemName: settingsVM.selectedMapStyle.mapStyleSystemImageName)
                .foregroundStyle(Color.accentColor)
                .padding(11.5)
                .mapControlButtonBackground
                .defaultTypeSizeViewModifier
                .popoverTip(settingsVM.mapStyleButtonTip)
        }
        .mapControlButtonShadow
        .buttonStyle(.plain)
    }
    
    @ViewBuilder
    private var glassButton: some View {
        if #available(iOS 26.0, *) {
            Button {
                mapVM.setNextMapStyle()
            } label: {
                Image(systemName: settingsVM.selectedMapStyle.mapStyleSystemImageName)
                    .foregroundStyle(Color.accentColor)
                    .padding(11.5)
                    .mapControlButtonBackground
                    .glassEffect(.regular)
                    .defaultTypeSizeViewModifier
                    .popoverTip(settingsVM.mapStyleButtonTip)
            }
            .buttonStyle(.plain)
        }
    }
}
