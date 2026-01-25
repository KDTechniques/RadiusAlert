//
//  CircularRadiusTextView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI
import CoreLocation

struct CircularRadiusTextView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    let radius: CLLocationDistance
    
    // MARK: - INITIALIZER
    init(radius: CLLocationDistance) {
        self.radius = radius
    }
    
    // MARK: - BODY
    var body: some View {
        Text(mapVM.getRadiusTextString(radius, withAlertRadiusText: true))
            .multilineTextAlignment(.center)
            .font(.caption)
            .fontWeight(.medium)
            .frame(maxWidth: Utilities.screenWidth/4)
            .lineLimit(4)
            .offset(y: MapValues.pinHeight/2)
    }
}

// MARK: - PREVIEWS
#Preview("CircularRadiusTextView") {
    CircularRadiusTextView(radius: MapValues.minimumRadius)
        .previewModifier()
}
