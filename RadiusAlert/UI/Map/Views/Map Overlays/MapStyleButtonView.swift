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
#Preview("Map Style Button View") {
    ButtonView()
        .previewModifier()
}

//  MARK: - SUB VIEWS
fileprivate struct ButtonView: View {
    @Environment(MapViewModel.self) private var mapVM
    @Environment(SettingsViewModel.self) private var settingsVM
    
    var body: some View {
        Button {
            mapVM.setNextMapStyle()
        } label: {
            Image(systemName: settingsVM.selectedMapStyle.mapStyleSystemImageName)
                .foregroundStyle(Color.accentColor)
                .padding(11.5)
                .buttonBackground
                .defaultTypeSizeViewModifier
        }
        .buttonBackground
        .frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .bottomTrailing)
        .padding(.trailing, 5)
        .padding(.bottom, 30)
        .buttonStyle(.plain)
    }
}

// MARK: - EXTENSIONS
fileprivate extension View {
    var buttonBackground: some View {
        self
            .background(
                Color.custom.Map.mapControlButtonBackground.color,
                in: .rect(cornerRadius: 7)
            )
    }
}
