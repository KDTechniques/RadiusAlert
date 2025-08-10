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
        @Bindable var mapVM: MapViewModel = mapVM
        
        SearchBarView(
            searchBarText: $mapVM.searchText,
            placeholder: "Search",
            context: .custom,
            customColors: .init(
                backgroundColor: .searchBarBackground,
                searchIconTextColor: .searchBarForeground,
                placeholderTextColor: .searchBarForeground,
                textColor: .primary
            )
        ) { mapVM.isSearchFieldFocused = $0 }
            .focused($isFocused)
            .submitLabel(.search)
            .onSubmit { isFocused = false }
            .padding(.bottom, 14)
            .padding(.top, 8)
    }
}

// MARK: - PREVIEWS
#Preview("Search Bar") {
    SearchBarSwiftUIView()
        .previewModifier()
}
