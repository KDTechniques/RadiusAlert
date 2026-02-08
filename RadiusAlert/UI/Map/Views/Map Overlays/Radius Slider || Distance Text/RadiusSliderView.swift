//
//  RadiusSliderView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2026-01-23.
//

import SwiftUI

struct RadiusSliderView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @Environment(MapViewModel.self) private var mapVM
    
    @Binding var value: Double
    let onSlidingEnded: () -> Void
    
    // MARK: - INITIALIZER
    init(value: Binding<Double>, _ onSlidingEnded: @escaping () -> Void) {
        _value = value
        self.onSlidingEnded = onSlidingEnded
    }
    
    // MARK: - ASSIGNED PROPERTIES
    let mapValues: MapValues.Type = MapValues.self
    
    // MARK: - BODY
    var body: some View {
        Slider(
            value: $value,
            in: mapValues.minimumRadius...mapValues.maximumRadius,
            step: mapValues.radiusStep) { }
        minimumValueLabel: {
            Text(mapValues.minimumRadiusString)
                .radiusSliderViewModifier(colorScheme)
        } maximumValueLabel: {
            Text(mapValues.maximumRadiusString)
                .radiusSliderViewModifier(colorScheme)
        } onEditingChanged: { $0 ? () : onSlidingEnded() }
    }
}

// MARK: - PREVIEWS
#Preview("RadiusSliderView") {
    @Previewable @State var sliderValue: Double = MapValues.minimumRadius
    RadiusSliderView(value: $sliderValue) { print("Sliding Ended!") }
        .padding()
        .previewModifier()
}

// MARK: - EXTENSIONS
fileprivate extension View {
    func radiusSliderViewModifier(_ colorScheme: ColorScheme) -> some View {
        self
            .foregroundStyle(Color(uiColor: colorScheme == .dark ? .white : .darkGray))
            .font(.caption)
            .fontWeight(.semibold)
            .shadow(
                color: .getNotPrimary(colorScheme: colorScheme),
                radius: 0.3,
                y: -0.5
            )
    }
}
