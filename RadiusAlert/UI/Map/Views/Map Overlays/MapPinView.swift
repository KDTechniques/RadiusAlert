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
        Image(systemName: "mappin")
            .font(.largeTitle)
            .foregroundStyle(.red.gradient)
            .opacity(mapVM.showMapPin() ? 1 : 0)
            .animation(.default, value: mapVM.showMapPin())
    }
}

// MARK: - PREVIEWS
#Preview("Map Pin View") {
    MapPinView()
        .previewModifier()
}
