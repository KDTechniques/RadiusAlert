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
    @Environment(SettingsViewModel.self) private var settingsVM
    
    @Binding var value: Double
    let onSlidingEnded: () -> Void
    
    // MARK: - INITIALIZER
    init(value: Binding<Double>, _ onSlidingEnded: @escaping () -> Void) {
        _value = value
        self.onSlidingEnded = onSlidingEnded
    }
    
    // MARK: - BODY
    var body: some View {
        Slider(
            value: $value,
            in: MapValues.minimumRadius...MapValues.maximumRadius,
            step: MapValues.radiusStep) { }
        minimumValueLabel: {
            Text(MapValues.minimumRadiusString)
                .radiusSliderViewModifier(colorScheme, mapStyle: settingsVM.selectedMapStyle)
        } maximumValueLabel: {
            Text(MapValues.maximumRadiusString)
                .radiusSliderViewModifier(colorScheme, mapStyle: settingsVM.selectedMapStyle)
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
    @ViewBuilder
    func radiusSliderViewModifier(_ colorScheme: ColorScheme, mapStyle: MapStyleTypes) -> some View {
        var colors: (foreground: Color, shadow: Color) {
            switch mapStyle {
            case .standard:
                return (.init(uiColor: colorScheme == .dark ? .white : .darkGray), .getNotPrimary(colorScheme: colorScheme))
            case .hybrid, .imagery:
                return (.white, .black)
            }
        }
        
        self
            .foregroundStyle(colors.foreground)
            .font(.caption)
            .fontWeight(.semibold)
            .shadow(
                color: colors.shadow,
                radius: 0.3,
                y: -0.5
            )
    }
}
