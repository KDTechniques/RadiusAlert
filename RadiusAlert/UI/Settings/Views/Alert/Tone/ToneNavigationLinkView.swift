//
//  ToneNavigationLinkView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-19.
//

import SwiftUI

struct ToneNavigationLinkView: View {
    // MARK: - BODY
    var body: some View {
        List {
            NavigationLink {
                ToneListSectionView()
            } label: {
                Text("Tone")
            }
        }
        .navigationTitle(Text("Alerts"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - PREVIEWS
#Preview("Tone List Section") {
    NavigationStack {
        ToneNavigationLinkView()
    }
    .previewModifier()
}
