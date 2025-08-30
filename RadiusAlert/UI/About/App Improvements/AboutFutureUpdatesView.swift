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
                ForEach(UpdateTypes.futureUpdates) { update in
                    HStack {
                        Text(update.emoji)
                        Text(update.description)
                    }
                }
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
