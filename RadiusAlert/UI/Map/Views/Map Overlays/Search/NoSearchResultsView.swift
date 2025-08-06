//
//  NoSearchResultsView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-06.
//

import SwiftUI

struct NoSearchResultsView: View {
    // MARK: - BODY
    var body: some View {
        Text("No results")
            .fontWeight(.semibold)
            .foregroundStyle(.secondary)
    }
}

// MARK: - PREVIEWS
#Preview("No Search Results View") {
    NoSearchResultsView()
        .previewModifier()
}
