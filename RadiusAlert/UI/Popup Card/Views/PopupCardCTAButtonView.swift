//
//  PopupCardCTAButtonView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-09.
//

import SwiftUI

struct PopupCardCTAButtonView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        Button {
            mapVM.stopAlert()
        } label: {
            Text("OK")
                .textTintViewModifier(colorScheme)
                .fontWeight(.medium)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .glassEffectViewModifier
        }
        .padding(.top)
    }
}

// MARK: - PREVIEWS
#Preview("PopupCardCTAButtonView") {
    PopupCardCTAButtonView()
        .padding(.horizontal, 50)
        .previewModifier()
}

// MARK: EXTENSIONS
fileprivate extension View {
    @ViewBuilder
    var glassEffectViewModifier: some View {
        if #available(iOS 26.0, *) {
            self
                .glassEffect(.clear.tint(.primary))
        } else {
            self
                .background(.regularMaterial, in: .rect(cornerRadius: 12))
        }
    }
    
    @ViewBuilder
    func textTintViewModifier(_ colorScheme: ColorScheme) -> some View {
        if #available(iOS 26.0, *) {
            self
                .tint(.getNotPrimary(colorScheme: colorScheme))
        } else {
            self
                .tint(.primary)
        }
    }
}
