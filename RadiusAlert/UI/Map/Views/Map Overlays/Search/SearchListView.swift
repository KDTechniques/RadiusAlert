//
//  SearchListView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-06.
//

import SwiftUI

struct SearchListView: View {
    // MARK: - BODY
    var body: some View {
        SearchResultsListView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - PREVIEWS
#Preview("Search List View") {
    SearchListView()
        .background(.regularMaterial)
        .previewModifier()
}
