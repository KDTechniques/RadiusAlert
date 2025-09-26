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
        .onChange(of: mapVM.showRadiusSlider()) {
            RadiusSliderTipModel.isSliderVisible = $1
        }
    }
}

// MARK: - PREVIEWS
#Preview("Radius Slider View - SliderView") {
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
        .tipImageStyle(.primary.opacity(0.3))
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
