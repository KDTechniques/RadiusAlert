//
//  CTAButtonView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct CTAButtonView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        Button {
            mapVM.triggerCTAButtonAction()
        } label: {
            Text(mapVM.isMarkerCoordinateNil() ? "Alert Me Here" : "Stop Alert")
                .fontWeight(.semibold)
                .foregroundStyle(mapVM.getCTAButtonForegroundColor())
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(mapVM.getCTAButtonBackgroundColor(), in: .rect(cornerRadius: 12))
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 20)
        .padding(.horizontal, 45)
        .background(.regularMaterial)
    }
}

// MARK: - PREVIEWS
#Preview("Call to Action Button View") {
    CTAButtonView()
        .previewModifier()
}
