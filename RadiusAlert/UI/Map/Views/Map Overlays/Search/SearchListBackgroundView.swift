//
//  SearchListBackgroundView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import SwiftUI

struct SearchListBackgroundView: View {
    // MARK: -  INJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        if mapVM.showSearchListBackground() {
            MapValues.safeAreaBackgroundColor(colorScheme)
                .frame(height: mapVM.searchResultBackgroundHeight)
                .overlay(alignment: .top) { SearchListContentView() }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .ignoresSafeArea()
        }
    }
}

// MARK: - PREVIEWS
#Preview("SearchListBackgroundView") {
    SearchListBackgroundView()
        .previewModifier()
}
