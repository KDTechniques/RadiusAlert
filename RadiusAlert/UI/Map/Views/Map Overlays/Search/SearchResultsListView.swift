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
        if let searchResults: [MKMapItem] = mapVM.searchResults {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    ForEach(searchResults, id: \.self) { item in
                        if let name: String = item.name {
                            let placeMark: MKPlacemark = item.placemark
                            let title: String = placeMark.title ?? placeMark.subtitle ?? ""
                            
                            Button {
                                mapVM.onSearchResultsListRowTap(item)
                            } label: {
                                SearchResultListRowView(name: name, title: title)
                            }
                            .buttonStyle(.plain)
                        }
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
