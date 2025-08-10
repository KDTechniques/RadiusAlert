//
//  SearchListBackgroundView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import SwiftUI

struct SearchListBackgroundView: View {
    // MARK: -  INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - ASSIGNED PROPERTIES
    let mapValues: MapValues.Type = MapValues.self
    
    // MARK: - BODY
    var body: some View {
        if mapVM.isSearchFieldFocused {
            mapValues.safeAreaBackgroundColor
                .ignoresSafeArea()
        }
    }
}

// MARK: - PREVIEWS
#Preview("Search List Background") {
    SearchListBackgroundView()
        .previewModifier()
}
