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
                .buttonBackground
                .defaultTypeSizeViewModifier
                .popoverTip(settingsVM.mapStyleButtonTip)
        }
        .buttonBackground
        .frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .bottomTrailing)
        .padding(.trailing, 5)
        .padding(.bottom, 40)
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
                    .glassButtonBackground
                    .glassEffect(.regular)
                    .defaultTypeSizeViewModifier
                    .popoverTip(settingsVM.mapStyleButtonTip)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .bottomTrailing)
            .padding(.trailing)
            .padding(.bottom, 40)
            .buttonStyle(.plain)
        }
    }
}

fileprivate extension View {
    var buttonBackground: some View {
        self
            .background(
                Color.custom.Map.mapControlButtonBackground.color,
                in: .rect(cornerRadius: 7)
            )
    }
    
    var glassButtonBackground: some View {
        self
            .background(
                Color.primary.opacity(0.001),
                in: .circle
            )
    }
}
