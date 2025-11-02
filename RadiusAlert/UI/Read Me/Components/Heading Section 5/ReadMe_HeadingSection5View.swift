//
//  ReadMe_HeadingSection5View.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-14.
//

import SwiftUI

struct ReadMe_HeadingSection5View: View {
    // MARK: - BODY
    var body: some View {
        heading
        description1
        description2
        description3
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_HeadingSection5View") {
    VStack(alignment: .leading, spacing: 10) {
        ReadMe_HeadingSection5View()
    }
    .padding(.horizontal, ReadMe_Values.padding)
    .previewModifier()
}

// MARK: - EXTENSIONS
extension ReadMe_HeadingSection5View {
    private var heading: some View {
        Text("🚫 Distraction-Free")
            .readMeHeading1ViewModifier
            .readMeHeadingSectionToSectionPadding
    }
    
    private var description1: some View {
        Text("No ads. No in-app purchases. It's free!")
            .readMeBodyViewModifier
    }
    
    private var description2: some View {
        Text("No clutter. A clean, simple interface focused only on your journey.")
            .readMeBodyViewModifier
    }
    
    private var description3: some View {
        Text("Dark Mode supported for comfortable night use.")
            .readMeBodyViewModifier
    }
}
