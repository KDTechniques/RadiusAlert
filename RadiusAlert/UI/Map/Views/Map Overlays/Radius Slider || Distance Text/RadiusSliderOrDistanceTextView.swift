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
    @Environment(\.colorScheme) private var colorScheme
    @Environment(MapViewModel.self) private var mapVM
    
    //  MARK: - ASSIGNED PROPERTIES
    let mapValues: MapValues.Type = MapValues.self
    let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .trailing) {
            radiusSlider
            distanceText
        }
        .frame(width: screenWidth/mapValues.radiusSliderWidthFactor)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .padding(.trailing, 10)
        .animation(.default, value: mapVM.showPrimaryRadiusSliderOrDistanceText())
    }
}

// MARK: - PREVIEWS
#Preview("RadiusSliderOrDistanceTextView - RadiusSliderView") {
    @Previewable @State var sliderValue: Double = MapValues.minimumRadius
    @Previewable @State var mapVM: MapViewModel = .init(settingsVM: .init())
    
    VStack {
        RadiusSliderView(value: $sliderValue) { print($0) }
            .popoverTip(mapVM.radiusSliderTip)
            .padding()
        
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

// MARK: - EXTENSIONS
extension RadiusSliderOrDistanceTextView {
    private var radiusSlider: some View {
        RadiusSliderView(value: mapVM.primarySelectedRadiusBinding()) { mapVM.onRadiusSliderEditingChanged($0) }
            .opacity(mapVM.showPrimaryRadiusSliderOrDistanceText() == .radiusSlider ? 1 : 0)
            .disabled(mapVM.showPrimaryRadiusSliderOrDistanceText() != .radiusSlider)
            .popoverTip(mapVM.radiusSliderTip)
            .tipImageStyle(colorScheme == .dark ? .secondary : Color(uiColor: .systemGray3))
            .onReceive(NotificationCenter.default.publisher(for: .radiusSliderTipDidTrigger)) { _ in
                mapVM.onRadiusSliderTipAction()
            }
    }
    
    private var distanceText: some View {
        DistanceTextView(mapVM.distanceText)
            .opacity(mapVM.showPrimaryRadiusSliderOrDistanceText() == .distanceText ? 1 : 0)
            .disabled(mapVM.showPrimaryRadiusSliderOrDistanceText() != .distanceText)
    }
}
