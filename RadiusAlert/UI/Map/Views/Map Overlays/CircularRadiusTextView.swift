//
//  CircularRadiusTextView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct CircularRadiusTextView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        Text("Alert Radius\n\(mapVM.radiusTextHandler())")
            .multilineTextAlignment(.center)
            .font(.caption)
            .fontWeight(.medium)
            .offset(y: 40)
            .opacity(mapVM.showRadiusCircle ? 1 : 0)
    }
}

// MARK: - PREVIEWS
#Preview("CircularRadiusTextView") {
    CircularRadiusTextView()
        .previewModifier()
}
