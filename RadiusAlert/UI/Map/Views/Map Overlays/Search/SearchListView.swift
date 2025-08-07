//
//  SearchListView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-06.
//

import SwiftUI

struct SearchListView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        Group {
            if mapVM.showSearchResults() {
                SearchResultsListView()
            } else if mapVM.showNoSearchResultsText() {
                NoSearchResultsView()
            }  else if mapVM.showSearchingCircularProgress() {
                ProgressView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - PREVIEWS
#Preview("Search List View") {
    SearchListView()
        .background(.regularMaterial)
        .previewModifier()
}
