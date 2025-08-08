//
//  TopSafeAreaView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct TopSafeAreaView: View {
    // MARK: - INNJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - ASSIGNED PROPERTIES
    let mapValues: MapValues.Type = MapValues.self
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 0) {
            NavigationTitleButtonView()
            SearchBarSwiftUIView()
            Divider()
            searchList
        }
        .padding(.top, 40)
        .background(mapValues.safeAreaBackgroundColor)
    }
}

// MARK: - PREVIEWS
#Preview("Top Safe Area Content") {
    VStack {
        TopSafeAreaView()
        Spacer()
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension TopSafeAreaView {
    @ViewBuilder
    private var searchList: some View {
        if mapVM.showSearchResultsList() {
            SearchListView()
        }
    }
}
