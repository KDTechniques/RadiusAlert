//
//  RadiusSliderOrDistanceTextView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI
import TipKit
import CoreLocation


// MARK: - TODO:
/// The `RadiusSliderOrDistanceTextView` must be controlled within a ZStack and opacity and disabled modifiers by `showRadiusSlider`, and `showDistanceText`validation functions.

struct RadiusSliderOrDistanceTextView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    //  MARK: - ASSIGNED PROPERTIES
    let mapValues: MapValues.Type = MapValues.self
    let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .trailing) {
            RadiusSliderView()
                .opacity(mapVM.showRadiusSliderOrDistanceText() == .radiusSlider ? 1 : 0)
                .disabled(mapVM.showRadiusSliderOrDistanceText() != .radiusSlider)
            
            DistanceTextView(mapVM.distanceText)
                .opacity(mapVM.showRadiusSliderOrDistanceText() == .distanceText ? 1 : 0)
                .disabled(mapVM.showRadiusSliderOrDistanceText() != .distanceText)
        }
        .frame(width: screenWidth/mapValues.radiusSliderWidthFactor)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .padding(.trailing, 10)
        .animation(.default, value: mapVM.showRadiusSliderOrDistanceText())
    }
}

// MARK: - PREVIEWS
#Preview("RadiusSliderOrDistanceTextView - RadiusSliderView") {
    VStack {
        RadiusSliderView()
        
        Button("Show Tip") {
            RadiusSliderTipModel.isSetRadius.toggle()
            RadiusSliderTipModel.isSliderVisible.toggle()
        }
    }
    .padding(.horizontal, 50)
    .previewModifier()
}


#Preview("RadiusSliderOrDistanceTextView - DistanceTextView") {
    @Previewable @State var randomNumber: CLLocationDistance = .zero
    DistanceTextView(randomNumber)
        .scaleEffect(2)
        .onTapGesture {
            randomNumber = Double.random(in: 0...300)
        }
        .previewModifier()
}
