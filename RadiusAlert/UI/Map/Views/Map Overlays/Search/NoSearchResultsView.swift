//
//  NoSearchResultsView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-06.
//

import SwiftUI

struct NoSearchResultsView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        if mapVM.showNoSearchResultsText() {
            Text("No results")
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
        }
    }
}

// MARK: - PREVIEWS
#Preview("No Search Results View") {
    NoSearchResultsView()
        .previewModifier()
}
