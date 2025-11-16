//
//  SearchBarSwiftUIView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import SwiftUI
import SearchBarSwiftUI

struct SearchBarSwiftUIView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    @FocusState private var isFocused: Bool
    
    // MARK: - BODY
    var body: some View {
        SearchBarView(
            searchBarText: mapVM.searchTextBinding(),
            placeholder: "Search",
            context: .custom(.init(
                backgroundColor: .custom.SearchBar.searchBarBackground.color,
                searchIconTextColor: .custom.SearchBar.searchBarForeground.color,
                placeholderTextColor: .custom.SearchBar.searchBarForeground.color,
                textColor: .primary
            )),
            isSearching: mapVM.locationSearchManager.isSearching
        )
        .focused($isFocused)
        .submitLabel(.search)
        .padding(.bottom)
        .onChange(of: isFocused) { mapVM.setSearchFieldFocused($1) }
        .onChange(of: mapVM.isSearchFieldFocused) { isFocused = $1 }
    }
}

// MARK: - PREVIEWS
#Preview("SearchBarSwiftUIView") {
    SearchBarSwiftUIView()
        .previewModifier()
}
