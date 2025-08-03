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
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            ZStack {
                MapView()
                    .overlay {
                        MapPinView()
                        CircularRadiusTextView()
                        MapStyleButtonView()
                        RadiusSliderView()
                    }
            }
            .safeAreaInset(edge: .top, spacing: 0) { TopSafeAreaView() }
            .safeAreaInset(edge: .bottom, spacing: 0) { BottomSafeAreaView() }
            .toolbarVisibility(.hidden, for: .navigationBar)
        }
        .onAppear { mapVM.positionToInitialUserLocation() }
    }
}

// MARK: - PREVIEWS
#Preview("Content View") {
    ContentView()
        .previewModifier()
}
