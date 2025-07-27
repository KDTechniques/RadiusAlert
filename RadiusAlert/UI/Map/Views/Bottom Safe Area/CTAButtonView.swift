//
//  CTAButtonView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct CTAButtonView: View {
    // MARK: - BODY
    var body: some View {
        Button {
            // action goes here...
        } label: {
            Text("Alert Me Here")
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.green, in: .rect(cornerRadius: 12))
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.ultraThinMaterial)
    }
}

// MARK: - PREVIEWS
#Preview("Call to Action Button View") {
    CTAButtonView()
        .previewModifier()
}
