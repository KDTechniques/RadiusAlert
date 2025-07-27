//
//  RadiusSliderView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct RadiusSliderView: View {
    // MARK: - INJECTED PROPERTIES
    @EnvironmentObject private var contentVM: ContentViewModel
    
    // MARK: - BODY
    var body: some View {
        Slider(value: $contentVM.radius, in: 300...1000, step: 100)
            .frame(width: 200)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .padding(.trailing)
    }
}

// MARK: - PREVIEWS
#Preview("Radius Slider View") {
    RadiusSliderView()
        .previewModifier()
}
