//
//  AboutWhatsNewView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-13.
//

import SwiftUI

struct AboutWhatsNewView: View {
    // MARK: - BODY
    var body: some View {
        NavigationLink {
            List {
                Text("• Bullet points list of what's new goes here.")
            }
            .navigationTitle(Text("What's New"))
            .navigationBarTitleDisplayMode(.inline)
        } label: {
            Text("What's New ✨")
        }
    }
}

#Preview("About - Whats New") {
    NavigationStack {
        AboutWhatsNewView()
    }
    .previewModifier()
}
