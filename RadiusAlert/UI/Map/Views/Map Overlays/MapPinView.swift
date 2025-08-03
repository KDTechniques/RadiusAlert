//
//  MapPinView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct MapPinView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        let showMapPin: Bool = mapVM.isBeyondMinimumDistance()
        Image(systemName: "mappin")
            .font(.largeTitle)
            .foregroundStyle(.red)
            .opacity(showMapPin ? 1 : 0)
            .animation(.smooth(duration: 0.3), value: showMapPin)
    }
}

// MARK: - PREVIEWS
#Preview("Map Pin View") {
    MapPinView()
        .previewModifier()
}
