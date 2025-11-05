//
//  AddPinButtonView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-04.
//

import SwiftUI

struct AddPinButtonView: View {
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
#Preview("AddPinButtonView") {
    AddPinButtonView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension AddPinButtonView {
    private var nonGlassButton: some View {
        Button {
            // action goes here...
        } label: {
            Image(systemName: "plus")
                .fontWeight(.medium)
                .foregroundStyle(Color.accentColor)
                .frame(width: 44, height: 44)
                .mapControlButtonBackground
                .defaultTypeSizeViewModifier
        }
        .mapControlButtonShadow
    }
    
    @ViewBuilder
    private var glassButton: some View {
        if #available(iOS 26.0, *) {
            Button {
                // action goes here...
            } label: {
                Image(systemName: "plus")
                    .fontWeight(.medium)
                    .foregroundStyle(Color.accentColor)
                    .frame(width: 44, height: 44)
                    .mapControlButtonBackground
                    .glassEffect(.regular)
                    .defaultTypeSizeViewModifier
            }
            .buttonStyle(.plain)
        }
    }
}
