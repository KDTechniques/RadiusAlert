//
//  ReadMe_HeadingSection4View.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-14.
//

import SwiftUI

struct ReadMe_HeadingSection4View: View {
    // MARK: - BODY
    var body: some View {
        heading
        description1
        description2
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_HeadingSection4View") {
    VStack(alignment: .leading, spacing: 10) {
        ReadMe_HeadingSection4View()
    }
    .padding(.horizontal, ReadMe_Values.padding)
    .previewModifier()
}

// MARK: - EXTENSIONS
extension ReadMe_HeadingSection4View {
    private var heading: some View {
        Text("🔋 Battery-Friendly by Design")
            .readMeHeading1ViewModifier
            .readMeHeadingSectionToSectionPadding
    }
    
    private var description1: some View {
        Text("Location updates are optimized for minimal battery drain.")
            .readMeBodyViewModifier
    }
    
    private var description2: some View {
        Text("When your iPhone is locked, the app avoids unnecessary activity and only focuses on delivering accurate alerts.")
            .readMeBodyViewModifier
    }
}
