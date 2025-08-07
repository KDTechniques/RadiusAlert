//
//  TopSafeAreaView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI
import SearchBarSwiftUI

struct TopSafeAreaView: View {
    // MARK: - INNJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 0) {
            navigationTitleButton
            searchBar
            Divider()
            searchList
        }
        .padding(.top, 40)
        .background(.regularMaterial)
    }
}

// MARK: - PREVIEWS
#Preview("Top Safe Area Views") {
    NavigationStack {
        VStack {
            TopSafeAreaView()
            Spacer()
        }
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension TopSafeAreaView {
    private var navigationTitleButton: some View {
        HStack(spacing: 5) {
            Text("Radius Alert")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Image(.logo)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(height: 50)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
    }
    
    @ViewBuilder
    private var searchBar: some View {
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
            .onSubmit { mapVM.searchLocation() }
            .padding(.bottom, 14)
            .padding(.top, 8)
    }
    
    @ViewBuilder
    private var searchList: some View {
        if mapVM.showSearchResultsList() { SearchListView() }
    }
}
