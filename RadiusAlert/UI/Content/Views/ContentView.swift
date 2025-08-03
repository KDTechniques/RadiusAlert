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
                        RadiusSliderView()
                        
                        Image(.logo) //make this an SVG icon for trasparency
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44)
                            .frame(maxWidth: .infinity, maxHeight: .infinity,  alignment: .topTrailing)
                            .padding(.top, 30)
                            .padding(.horizontal, 5)
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
