//
//  AboutFutureUpdatesView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-13.
//

import SwiftUI

struct AboutFutureUpdatesView: View {
    var body: some View {
        NavigationLink {
            List {
                Text("• Bullet points list of future updates goes here.")
            }
            .navigationTitle(Text("Future Updates"))
            .navigationBarTitleDisplayMode(.inline)
        } label: {
            Text("Future Updates 📲")
        }
    }
}

// MARK: - PREVIEWS
#Preview("About - Future Updates") {
    NavigationStack {
        AboutFutureUpdatesView()
    }
    .previewModifier()
}
