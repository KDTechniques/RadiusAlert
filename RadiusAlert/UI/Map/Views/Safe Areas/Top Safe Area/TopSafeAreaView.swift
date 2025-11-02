//
//  TopSafeAreaView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-07-27.
//

import SwiftUI

struct TopSafeAreaView: View {
    // MARK: - INNJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - ASSIGNED PROPERTIES
    let mapValues: MapValues.Type = MapValues.self
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 0) {
            NavigationTitleButtonView()
            SearchBarSwiftUIView()
            HorizontalPinView()
            Divider()
            SearchResultsListView()
        }
        .padding(.top, 40)
        .background(mapValues.safeAreaBackgroundColor(colorScheme))
    }
}

// MARK: - PREVIEWS
#Preview("TopSafeAreaView") {
    NavigationStack {
        VStack {
            TopSafeAreaView()
            Spacer()
        }
    }
    .previewModifier()
}
