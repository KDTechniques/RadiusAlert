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
    
    // MARK: - ASSIGNEND PROPERTIES
    let mapValues: MapValues.Type = MapValues.self
    
    // MARK: - BODY
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

// MARK: - PREVIEWS
#Preview("RadiusSliderView") {
    RadiusSliderView()
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
