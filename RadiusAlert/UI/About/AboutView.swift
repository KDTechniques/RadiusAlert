//
//  AboutView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-12.
//

import SwiftUI

struct AboutView: View {
    // MARK: - BODY
    var body: some View {
        List {
            AboutBasicInfoView()
            AboutAppImprovementsView()
            AboutSomethingBoringView()
        }
        .navigationTitle(Text("About"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - PREVIEWS
#Preview("About") {
    NavigationStack {
        AboutView()
    }
    .previewModifier()
}
