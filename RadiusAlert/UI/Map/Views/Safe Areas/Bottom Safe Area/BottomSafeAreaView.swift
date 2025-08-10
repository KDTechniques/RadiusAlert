//
//  BottomSafeAreaView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct BottomSafeAreaView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - ASSIGNED PROPERTIES
    let mapValues: MapValues.Type = MapValues.self
    
    // MARK: - BODY
    var body: some View {
        Group {
            if mapVM.showCTAButton() {
                CTAButtonView()
            }
        }
        .background(mapValues.safeAreaBackgroundColor)
    }
}

// MARK: - PREVIEWS
#Preview("Bottom Safe Area Views") {
    BottomSafeAreaView()
        .previewModifier()
}
