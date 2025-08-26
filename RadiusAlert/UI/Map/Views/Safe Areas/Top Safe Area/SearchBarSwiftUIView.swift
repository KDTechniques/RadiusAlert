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
                backgroundColor: .searchBarBackground,
                searchIconTextColor: .searchBarForeground,
                placeholderTextColor: .searchBarForeground,
                textColor: .primary
            )),
            isSearching: mapVM.locationSearchManager.isSearching
        )
        .focused($isFocused)
        .submitLabel(.search)
        .onSubmit { handleOnSubmit() }
        .padding(.bottom, 14)
        .padding(.top, 8)
        .onChange(of: isFocused) { mapVM.setSearchFieldFocused($1) }
        .onChange(of: mapVM.isSearchFieldFocused) { isFocused = $1 }
    }
}

// MARK: - PREVIEWS
#Preview("Search Bar") {
    SearchBarSwiftUIView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension SearchBarSwiftUIView {
    private func handleOnSubmit() {
        isFocused = false
        mapVM.onSearchTextSubmit()
    }
}
