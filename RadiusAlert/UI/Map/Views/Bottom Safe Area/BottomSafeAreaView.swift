//
//  BottomSafeAreaView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct BottomSafeAreaView: View {
    // MARK: - BODY
    var body: some View {
        if true {
            CTAButtonView()
        } else {
            SearchResultsListView()
        }
    }
}

// MARK: - PREVIEWS
#Preview("Bottom Safe Area Views") {
    BottomSafeAreaView()
        .previewModifier()
}
