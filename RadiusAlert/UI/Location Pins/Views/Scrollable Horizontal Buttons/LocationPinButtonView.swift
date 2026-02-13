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
                .savedLocationPinButtonBackgroundViewModifier(type: type)
                .clipShape(.capsule)
                .savedLocationPinButtonGlassEffect(type: type, colorScheme: colorScheme)
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
