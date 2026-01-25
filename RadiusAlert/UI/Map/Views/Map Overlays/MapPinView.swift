//
//  MapPinView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct MapPinView: View {
    let mapValues = MapValues.self
    
    // MARK: - BODY
    var body: some View {
        let frameHeight: CGFloat = mapValues.pinHeight * 2
        
        Image(systemName: "mappin")
            .resizable()
            .scaledToFit()
            .foregroundStyle(.red.gradient)
            .frame(height: mapValues.pinHeight)
            .frame(height: frameHeight, alignment: .top)
    }
}

// MARK: - PREVIEWS
#Preview("MapPinView") {
    MapPinView()
        .previewModifier()
}
