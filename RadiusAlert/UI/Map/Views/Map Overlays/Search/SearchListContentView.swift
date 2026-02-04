//
//  SearchListContentView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-06.
//

import SwiftUI
import MapKit

struct SearchListContentView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        Group {
            switch mapVM.networkManager.connectionState {
            case .connected:
                if mapVM.showNoSearchResultsText() {
                    UnavailableView("No Results")
                } else {
                    switch mapVM.getMapSearchType() {
                    case .searchResults:
                        SearchResultsScrollView()
                    case .recentSearches:
                        RecentSearchesListView()
                    }
                }
            case .noConnection:
                if mapVM.showNoInternetConnectionText() {
                    UnavailableView("No Internet Connection", foregroundColor: .red)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

//  MARK: - PREVIEWS
#Preview("SearchListContentView") {
    Group {
        if Bool.random() {
            UnavailableView("No Results")
        } else {
            UnavailableView("No Internet Connection", foregroundColor: .red)
        }
    }
    .previewModifier()
}
