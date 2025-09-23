//
//  RadiusSliderView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI
import TipKit

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
            
            DistanceTextView()
        }
        .frame(width: screenWidth/mapValues.radiusSliderWidthFactor)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .padding(.trailing, 10)
        .animation(.default, value: mapVM.showRadiusSlider())
        .onReceive(NotificationCenter.default.publisher(for: .radiusSliderTipDidTrigger)) { _ in
            withAnimation {
                mapVM.setSelectedRadius(Array(stride(from: 1000, through: 2000, by: 100)).randomElement()!)
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("Radius Slider View - SliderView") {
    VStack {
        SliderView()
    
        Button("Show Tip") {
            RadiusSliderTipModel.isSetRadius = true
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
    let radiusSliderTip: RadiusSliderTipModel = .init()
    
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
            mapVM.setRadiusSliderActiveState($0)
        }
        .popoverTip(radiusSliderTip)
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
