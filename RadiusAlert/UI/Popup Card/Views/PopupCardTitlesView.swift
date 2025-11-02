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
            title
            subTitle
        }
        .padding(.bottom)
    }
}

// MARK: - PREVIEWS
#Preview("PopupCardTitlesView") {
    PopupCardTitlesView()
        .padding(.horizontal, 100)
        .previewModifier()
}

// MARK: - EXTENSIONS
extension PopupCardTitlesView {
    private var title: some View {
        Text("It's time!")
            .font(.title)
            .bold()
    }
    
    private var subTitle: some View {
        Text("You've arrived at your destination radius")
            .foregroundStyle(.secondary)
            .font(.callout)
            .multilineTextAlignment(.center)
    }
}
