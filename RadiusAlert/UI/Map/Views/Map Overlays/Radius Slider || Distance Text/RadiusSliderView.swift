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
    let onEditingChanged: (_ boolean: Bool) -> Void
    
    // MARK: - INITIALIZER
    init(value: Binding<Double>, _ onEditingChanged: @escaping (_ boolean: Bool) -> Void) {
        _value = value
        self.onEditingChanged = onEditingChanged
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
        } onEditingChanged: { onEditingChanged($0) }
    }
}

// MARK: - PREVIEWS
#Preview("RadiusSliderView") {
    @Previewable @State var sliderValue: Double = MapValues.minimumRadius
    RadiusSliderView(value: $sliderValue) { print($0) }
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
