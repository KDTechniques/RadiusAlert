//
//  BottomSafeAreaView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-03-02.
//

import SwiftUI

struct BottomSafeAreaView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - BODY
    var body: some View {
        CTAButtonView()
            .background(MapValues.safeAreaBackgroundColor(colorScheme).ignoresSafeArea())
    }
}

// MARK: - PREVIEWS
#Preview("BottomSafeAreaView") {
    VStack {
        Spacer()
        BottomSafeAreaView()
    }
    .previewModifier()
}
