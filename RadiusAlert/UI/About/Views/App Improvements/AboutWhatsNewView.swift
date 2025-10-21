//
//  AboutWhatsNewView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-10-14.
//

import SwiftUI

struct AboutWhatsNewView: View {
    var body: some View {
        NavigationLink {
            List {
                ForEach(UpdateTypes.whatsNew) { update in
                    HStack {
                        Text(update.emoji)
                        Text(update.description)
                    }
                }
            }
            .navigationTitle(Text("What's New"))
            .navigationBarTitleDisplayMode(.inline)
        } label: {
            Text("What's New ✨")
        }
    }
}

// MARK: - PREVIEWS
#Preview("AboutWhatsNewView") {
    NavigationStack {
        AboutWhatsNewView()
    }
    .previewModifier()
}
