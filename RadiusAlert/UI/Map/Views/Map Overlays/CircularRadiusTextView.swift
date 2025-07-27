//
//  CircularRadiusTextView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct CircularRadiusTextView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(ContentViewModel.self) private var contentVM
    
    // MARK: - BODY
    var body: some View {
        Text("Alert Radius\n\(Int(contentVM.radius))m")
            .multilineTextAlignment(.center)
            .font(.caption)
            .fontWeight(.medium)
            .offset(y: 30)
            .opacity(contentVM.centerCoordinate == nil ? 0 : 1)
    }
}

// MARK: - PREVIEWS
#Preview("CircularRadiusTextView") {
    CircularRadiusTextView()
        .previewModifier()
}
