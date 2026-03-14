//
//  MapOverlayButtonView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-03-09.
//

import SwiftUI
import TipKit

struct MapOverlayButtonView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    let systemImage: String
    let tip: (any Tip)?
    let action: () -> Void
    
    // MARK: - INITIALIZER
    init(systemImage: String, tip: (any Tip)? = nil, action: @escaping () -> Void) {
        self.systemImage = systemImage
        self.tip = tip
        self.action = action
    }
    
    // MARK: - BODY
    var body: some View {
        if #available(iOS 26.0, *) {
            glassButton
        } else {
            nonGlassButton
        }
    }
}

// MARK: - PREVIEWS
#Preview("MapOverlayButtonView") {
    MapOverlayButtonView(systemImage: "", action: {})
        .previewModifier()
}

// MARK: - EXTENSIONS
extension MapOverlayButtonView {
    private var buttonLabel: some View {
        Image(systemName: systemImage)
            .fontWeight(MapValues.overlayMapButtonFontWeight)
            .frame(width: 44, height: 44)
            .mapControlButtonBackgroundViewModifier
            .defaultTypeSizeViewModifier
            .popoverTip(tip)
    }
    
    private var nonGlassButton: some View {
        Button {
            action()
        } label: {
            buttonLabel
                .foregroundStyle(Color.accentColor)
        }
        .mapControlButtonShadowViewModifier
    }
    
    @ViewBuilder
    private var glassButton: some View {
        if #available(iOS 26.0, *) {
            Button {
                action()
            } label: {
                buttonLabel
                    .foregroundStyle(colorScheme == .dark ? .white : Color.accentColor)
                    .glassEffect(.regular)
            }
            .buttonStyle(.plain)
        }
    }
}
