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
            Content()
        }
    }
}

// MARK: - PREVIEWS
#Preview("CircularRadiusTextView") {
    Content()
        .previewModifier()
}

// MARK: - SUB VIEWS
fileprivate struct Content: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(MapViewModel.self) private var mapVM
    
    var body: some View {
        Text(mapVM.getRadiusTextString(mapVM.selectedRadius, withAlertRadiusText: true))
            .multilineTextAlignment(.center)
            .font(.caption)
            .fontWeight(.medium)
            .frame(maxWidth: Utilities.screenWidth/4)
            .lineLimit(4)
            .offset(y: 40)
            .animation(.none, value: mapVM.selectedRadius)
    }
}
