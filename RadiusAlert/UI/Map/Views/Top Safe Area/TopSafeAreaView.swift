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
    @Environment(ContentViewModel.self) private var contentVM
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 0) {
            navigationTitle
            searchBar
            
            Divider()
        }
        .background(.ultraThinMaterial)
    }
}

// MARK: - PREVIEWS
#Preview("Top Safe Area Views") {
    NavigationStack {
        TopSafeAreaView()
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension TopSafeAreaView {
    private var navigationTitle: some View {
        Text("Radius Alert")
            .fontWeight(.semibold)
    }
    
    @ViewBuilder
    private var searchBar: some View {
        @Bindable var contentVM: ContentViewModel = contentVM
        SearchBarView(searchBarText: $contentVM.searchText, placeholder: "Search", context: .navigation, customColors: nil) { _ in }
            .padding(.vertical)
    }
}
