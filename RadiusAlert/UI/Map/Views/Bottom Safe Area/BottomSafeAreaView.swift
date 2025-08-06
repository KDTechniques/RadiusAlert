//
//  BottomSafeAreaView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct BottomSafeAreaView: View {
    @Environment(MapViewModel.self) private var mapVM
    // MARK: - BODY
    var body: some View {
        if mapVM.showSearchResults() || mapVM.showNoSearchResultsText() || mapVM.showSearchingCircularProgress() {
            SearchListView()
        } else {
            CTAButtonView()
        }
    }
}

// MARK: - PREVIEWS
#Preview("Bottom Safe Area Views") {
    BottomSafeAreaView()
        .previewModifier()
}
