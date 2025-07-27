//
//  MapPinView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct MapPinView: View {
    // MARK: - BODY
    var body: some View {
        Image(systemName: "mappin")
            .font(.title)
            .foregroundStyle(.red)
    }
}

// MARK: - PREVIEWS
#Preview("Map Pin View") {
    MapPinView()
        .previewModifier()
}
