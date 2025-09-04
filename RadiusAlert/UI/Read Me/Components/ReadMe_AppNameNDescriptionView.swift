//
//  ReadMe_AppNameNDescriptionView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-04.
//

import SwiftUI

struct ReadMe_AppNameNDescriptionView: View, ReadMeComponents {
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Radius Alert")
                .font(.largeTitle.weight(.heavy))
            
            Text("Radius Alert is an iOS app designed to solve a simple but common problem: falling asleep or getting distracted during your bus or train ride — and missing your stop.")
                .foregroundStyle(.secondary)
                .fontWeight(.semibold)
        }
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_AppNameNDescriptionView") {
    ReadMe_AppNameNDescriptionView()
        .previewModifier()
}
