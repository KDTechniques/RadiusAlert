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
    @EnvironmentObject private var contentVM: ContentViewModel
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                navigationTitle
                navigationToSettingsLink
            }
            
            searchBar
            
            Divider()
        }
        .background(.ultraThinMaterial)
    }
}

// MARK: - PREVIEWS
#Preview("Top Safe Area Views") {
    TopSafeAreaView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension TopSafeAreaView {
    private var navigationTitle: some View {
        Text("Radius Alert")
            .fontWeight(.semibold)
    }
    
    private var navigationToSettingsLink: some View  {
        NavigationLink {
            // Settings View goes here...
        } label: {
            Image(systemName: "gear")
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
        }
    }
    
    @ViewBuilder
    private var searchBar: some View {
        SearchBarView(searchBarText: $contentVM.searchText, placeholder: "Search", context: .navigation, customColors: nil) { _ in }
            .padding(.vertical)
    }
}
