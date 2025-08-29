//
//  RadiusSliderView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct RadiusSliderView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @Environment(MapViewModel.self) private var mapVM
    
    //  MARK: - ASSIGNED PROPERTIES
    let mapValues: MapValues.Type = MapValues.self
    let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .trailing) {
            Slider(
                value: mapVM.selectedRadiusBinding(),
                in: mapValues.minimumRadius...mapValues.maximumRadius,
                step: mapValues.radiusStep) { }
            minimumValueLabel: {
                Text(mapValues.minimumRadiusString)
                    .radiusSliderViewModifier(colorScheme)
            } maximumValueLabel: {
                Text(mapValues.maximumRadiusString)
                    .radiusSliderViewModifier(colorScheme)
            } onEditingChanged: {
                mapVM.setRadiusSliderActiveState($0)
            }
            .opacity(mapVM.showRadiusSlider() ? 1 : 0)
            .disabled(!mapVM.showRadiusSlider())
            
            DistanceTextView()
        }
        .frame(width: screenWidth/mapValues.radiusSliderWidthFactor)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .padding(.trailing, 10)
        .animation(.default, value: mapVM.showRadiusSlider())
    }
}

// MARK: - PREVIEWS
#Preview("Radius Slider View") {
    RadiusSliderView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension View {
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
