//
//  RadiusSliderView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct RadiusSliderView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(ContentViewModel.self) private var contentVM
    
    // MARK: - BODY
    var body: some View {
        @Bindable var contentVM: ContentViewModel = contentVM
        Slider(value: $contentVM.radius, in: 500...2000, step: 100)
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
