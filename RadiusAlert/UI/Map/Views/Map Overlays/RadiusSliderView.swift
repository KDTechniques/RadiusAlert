//
//  RadiusSliderView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct RadiusSliderView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    //  MARK: - ASSIGNED PROPERTIES
    let mapValues: MapValues.Type = MapValues.self
    let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    
    let sliderLabelForegroundColor: Color = .init(uiColor: .darkGray)
    
    // MARK: - BODY
    var body: some View {
        @Bindable var mapVM: MapViewModel = mapVM
        Slider(
            value: $mapVM.radius,
            in: mapValues.minimumRadius...mapValues.maximumRadius,
            step: 100) { } minimumValueLabel: {
                Text(mapValues.minimumRadiusString)
                    .foregroundStyle(sliderLabelForegroundColor)
            } maximumValueLabel: {
                Text(mapValues.maximumRadiusString)
                    .foregroundStyle(sliderLabelForegroundColor)
            } onEditingChanged: { boolean in
                print(boolean)
            }
            .frame(width: screenWidth/mapValues.radiusSliderWidthFactor)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(.trailing)
        
        
        
    }
}

// MARK: - PREVIEWS
#Preview("Radius Slider View") {
    RadiusSliderView()
        .previewModifier()
}
