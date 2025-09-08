//
//  ReadMe_TitleTextView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-08.
//

import SwiftUI

struct ReadMe_TitleTextView: View {
    // MARK: - BODY
    var body: some View {
        Text("Radius Alert")
            .font(.largeTitle)
            .fontWeight(.heavy)
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_TitleTextView") {
    ReadMe_TitleTextView()
        .previewModifier()
}
