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
    
    // MARK: - ASSIGNED PROPERTIES
    let mapValues: MapValues.Type = MapValues.self
    
    // MARK: - BODY
    var body: some View {
        if mapVM.showSearchListBackground() {
            mapValues.safeAreaBackgroundColor(colorScheme)
                .ignoresSafeArea()
        }
    }
}

// MARK: - PREVIEWS
#Preview("SearchListBackgroundView") {
    SearchListBackgroundView()
        .previewModifier()
}
