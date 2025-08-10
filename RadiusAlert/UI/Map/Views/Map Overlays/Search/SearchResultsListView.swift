//
//  SearchResultsListView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-06.
//

import SwiftUI
import MapKit

struct SearchResultsListView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        if let lastItem: MKLocalSearchCompletion = mapVM.locationSearchManager.results.last {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    ForEach(mapVM.locationSearchManager.results, id: \.self) {
                        foreachItem(item: $0, lastItem: lastItem)
                    }
                }
            }
        }
    }
}

//  MARK: - PREVIEWS
#Preview("Searc Results List View") {
    SearchResultsListView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension SearchResultsListView {
    @ViewBuilder
    private func foreachItem(item: MKLocalSearchCompletion, lastItem: MKLocalSearchCompletion) ->  some View {
        Button {
            mapVM.onSearchResultsListRowTap(item)
        } label: {
            SearchResultListRowView(
                title: item.title,
                subTitle: item.subtitle,
                showSeparator: lastItem != item
            )
        }
        .buttonStyle(.plain)
    }
}
