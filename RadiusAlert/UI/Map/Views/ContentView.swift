//
//  ContentView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-07-27.
//

import SwiftUI
import SearchBarSwiftUI
import MapKit

struct ContentView: View {
    // MARK: - INJECTED PROPERTIES
    @EnvironmentObject private var contentVM: ContentViewModel
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            ZStack {
                MapView()
                    .overlay {
                        MapPinView()
                        CircularRadiusTextView()
                        RadiusSliderView()
                    }
            }
            .safeAreaInset(edge: .top, spacing: 0) { TopSafeAreaView() }
            .safeAreaInset(edge: .bottom, spacing: 0) { BottomSafeAreaView() }
            .toolbarVisibility(.hidden, for: .navigationBar)
        }
        .onAppear { contentVM.positionToInitialUserLocation() }
    }
}

// MARK: - PREVIEWS
#Preview("Content View") {
    ContentView()
        .previewModifier()
}
