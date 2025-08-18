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
        if mapVM.showFloatingAlertRadiusText() {
            Text(mapVM.getRadiusTextString(mapVM.selectedRadius, withAlertRadiusText: true))
                .multilineTextAlignment(.center)
                .font(.caption)
                .fontWeight(.medium)
                .offset(y: 40)
        }
    }
}

// MARK: - PREVIEWS
#Preview("CircularRadiusTextView") {
    CircularRadiusTextView()
        .previewModifier()
}
