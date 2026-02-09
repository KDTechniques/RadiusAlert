//
//  LocationPinButtonView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-03.
//

import SwiftUI

struct LocationPinButtonView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    let title: String
    let type: MapTypes
    let action: () -> Void
    
    // MARK: - INITIALIZER
    init(title: String, type: MapTypes, _ action: @escaping () -> Void) {
        self.title = title
        self.type = type
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
                .buttonBackground(type: type)
                .clipShape(.capsule)
                .pinButtonGlassEffect(type: type, colorScheme: colorScheme)
        }
        .foregroundStyle(.primary)
    }
}

// MARK: - PREVIEWS
#Preview("LocationPinButtonView") {
    LocationPinButtonView(title: LocationPinsModel.mock.randomElement()!.title, type: .random()) {
        print("Action Triggered!")
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
fileprivate extension View {
    @ViewBuilder
    func pinButtonGlassEffect(type: MapTypes, colorScheme: ColorScheme) -> some View {
        if #available(iOS  26.0, *) {
            let effect: Glass = {
                switch type {
                case .primary:
                    return .clear
                case .secondary:
                    return colorScheme == .dark ? .regular : .clear
                }
            }()
            
            self
                .glassEffect(effect)
        } else {
            self
                .overlay {
                    Capsule()
                        .strokeBorder(.primary.opacity(0.2), lineWidth: 0.6)
                }
        }
    }
    
    @ViewBuilder
    func buttonBackground(type: MapTypes) -> some View {
        switch type {
        case .primary:
            self.background(.regularMaterial)
            
        case .secondary:
            self.background(.clear)
        }
    }
}
