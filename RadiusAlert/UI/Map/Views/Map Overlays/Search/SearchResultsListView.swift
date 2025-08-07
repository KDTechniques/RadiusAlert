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
        if let searchResults: [MKMapItem] = mapVM.searchResults,
           let lastItem: MKMapItem = searchResults.last {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    ForEach(searchResults, id: \.self) {
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
    private func foreachItem(item: MKMapItem, lastItem: MKMapItem) ->  some View {
        if let name: String = item.name {
            let placeMark: MKPlacemark = item.placemark
            let title: String = placeMark.title ?? placeMark.subtitle ?? ""
            Button {
                mapVM.onSearchResultsListRowTap(item)
            } label: {
                SearchResultListRowView(
                    name: name,
                    title: title,
                    showSeparator: lastItem != item
                )
            }
            .buttonStyle(.plain)
        }
    }
}
