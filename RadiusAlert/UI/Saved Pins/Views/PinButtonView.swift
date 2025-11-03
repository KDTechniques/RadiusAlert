//
//  PinButtonView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-03.
//

import SwiftUI

struct PinButtonView: View {
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
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(.regularMaterial)
                .clipShape(.capsule)
                .font(.subheadline)
                .foregroundStyle(.primary)
                .pinButtonGlassEffect
        }
        .buttonStyle(.plain)
    }
}

// MARK: - PREVIEWS
#Preview("PinButtonView") {
    PinButtonView(title: PinModel.mock.first!.getLabel()) {
        print("Action Triggered!")
    }
}

// MARK: - EXTENSIONS
fileprivate extension View {
    @ViewBuilder
    var pinButtonGlassEffect: some View {
        if #available(iOS  26.0, *) {
            self
                .glassEffect()
        } else {
            self
                .overlay {
                    Capsule()
                        .strokeBorder(.primary.opacity(0.2), lineWidth: 0.6)
                }
        }
    }
}
