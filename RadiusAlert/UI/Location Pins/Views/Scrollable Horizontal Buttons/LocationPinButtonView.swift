//
//  LocationPinButtonView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-03.
//

import SwiftUI

struct LocationPinButtonView: View {
    // MARK: - INJECTED PROPERTIES
    let title: String
    let action: () -> Void
    
    // MARK: - INITIALIZER
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    // MARK: - BODY
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.subheadline)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .frame(maxWidth: Utilities.screenWidth/2)
                .background(.regularMaterial)
                .clipShape(.capsule)
                .pinButtonGlassEffect
        }
        .foregroundStyle(.primary)
    }
}

// MARK: - PREVIEWS
#Preview("LocationPinButtonView") {
    LocationPinButtonView(title: LocationPinsModel.mock.randomElement()!.title) {
        print("Action Triggered!")
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
fileprivate extension View {
    @ViewBuilder
    var pinButtonGlassEffect: some View {
        if #available(iOS  26.0, *) {
            self
                .glassEffect(.clear)
        } else {
            self
                .overlay {
                    Capsule()
                        .strokeBorder(.primary.opacity(0.2), lineWidth: 0.6)
                }
        }
    }
}
