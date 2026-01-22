//
//  RadiusSliderView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI
import TipKit
import CoreLocation


// MARK: - TODO:
/// Note: Take the slider from sub view and create a separate for that, and same goes for the distance text view as well.
/// Then create another view/ or keep this view by renaming it to `RadiusSliderOrDistanceTextView` and provide each parameter to each view.
/// The `RadiusSliderOrDistanceTextView` must be controlled within a ZStack and opacity and disabled modifiers by `showRadiusSlider`, and `showDistanceText`validation functions.

struct RadiusSliderView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    //  MARK: - ASSIGNED PROPERTIES
    let mapValues: MapValues.Type = MapValues.self
    let screenWidth: CGFloat = UIScreen.main.bounds.size.width
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .trailing) {
            SliderView()
                .opacity(mapVM.showRadiusSlider() ? 1 : 0)
                .disabled(!mapVM.showRadiusSlider())
            
            if let distance: CLLocationDistance = mapVM.getDistanceToRadius(
                coordinate1: mapVM.locationManager.currentUserLocation,
                coordinate2: mapVM.markerCoordinate, radius: mapVM.selectedRadius) {
                DistanceTextView(distance)
            }
        }
        .frame(width: screenWidth/mapValues.radiusSliderWidthFactor)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .padding(.trailing, 10)
        .animation(.default, value: mapVM.showRadiusSlider())
    }
}

// MARK: - PREVIEWS
#Preview("RadiusSliderView - SliderView") {
    VStack {
        SliderView()
        
        Button("Show Tip") {
            RadiusSliderTipModel.isSetRadius.toggle()
            RadiusSliderTipModel.isSliderVisible.toggle()
        }
    }
    .padding(.horizontal, 50)
    .previewModifier()
}

// MARK: - SUB VIEWS
fileprivate struct SliderView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(MapViewModel.self) private var mapVM
    
    let mapValues: MapValues.Type = MapValues.self
    
    var body: some View {
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
            mapVM.onRadiusSliderEditingChanged($0)
        }
        .popoverTip(mapVM.radiusSliderTip)
        .tipImageStyle(colorScheme == .dark ? .secondary : Color(uiColor: .systemGray3))
        .onReceive(NotificationCenter.default.publisher(for: .radiusSliderTipDidTrigger)) { _ in
            mapVM.onRadiusSliderTipAction()
        }
    }
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
