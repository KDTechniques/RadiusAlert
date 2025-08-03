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
        @Bindable var mapVM: MapViewModel = mapVM
        if mapVM.isMarkerCoordinateNil() {
            Slider(
                value: $mapVM.selectedRadius.animation(),
                in: mapValues.minimumRadius...mapValues.maximumRadius,
                step: mapValues.radiusStep) { }
            minimumValueLabel: {
                Text(mapValues.minimumRadiusString)
                    .radiusSliderViewModifier(colorScheme)
            } maximumValueLabel: {
                Text(mapValues.maximumRadiusString)
                    .radiusSliderViewModifier(colorScheme)
            } onEditingChanged: {
                mapVM.isRadiusSliderActive = $0
            }
            .frame(width: screenWidth/mapValues.radiusSliderWidthFactor)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(.trailing, 10)
        }
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
    }
}
