//
//  PopupCardTitlesView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-09.
//

import SwiftUI

struct PopupCardTitlesView: View {
    // MARK: - BODY
    var body: some View {
        VStack {
            // Title
            Text("It's time!")
                .font(.title)
                .bold()
            
            // Subtitle
            Text("You've arrived to your destination radius")
                .foregroundStyle(.secondary)
                .font(.callout)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical)
    }
}

// MARK: - PREVIEWS
#Preview("Popup Card Titles") {
    PopupCardTitlesView()
        .padding(.horizontal, 100)
        .previewModifier()
}
