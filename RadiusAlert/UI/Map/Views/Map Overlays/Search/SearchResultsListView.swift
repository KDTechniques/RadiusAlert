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
        Group {
            switch mapVM.networkManager.connectionState {
            case .connected:
                if mapVM.showNoSearchResultsText() {
                    UnavailableView("No Results")
                } else {
//                    searchResultList
                    SearchRecentsView()
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
#Preview("SearchResultsListView") {
    Group {
        if Bool.random() {
            UnavailableView("No Results")
        } else {
            UnavailableView("No Internet Connection", foregroundColor: .red)
        }
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension SearchResultsListView {
    @ViewBuilder
    private var searchResultList: some View {
        if let lastItemID: String = mapVM.locationSearchManager.results.last?.id {
            ScrollView(.vertical) {
                VStack(spacing: 0) {
                    ForEach(mapVM.locationSearchManager.results) {
                        foreachItem(item: $0, lastItemID: lastItemID)
                    }
                }
            }
            .onScrollPhaseChange { handleScrollPhase($1) }
        }
    }
    
    @ViewBuilder
    private func foreachItem(item: LocationSearchModel, lastItemID: String) ->  some View {
        Button {
            mapVM.onSearchResultsListRowTap(item.result)
        } label: {
            SearchResultListRowView(
                title: item.result.title,
                subTitle: item.result.subtitle,
                showSeparator: lastItemID != item.id
            )
        }
        .buttonStyle(.plain)
    }
    
    private func handleScrollPhase(_ phase: ScrollPhase) {
        guard phase.isScrolling else { return }
        mapVM.setSearchFieldFocused(false)
    }
}
