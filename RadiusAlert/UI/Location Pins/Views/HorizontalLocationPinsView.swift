//
//  HorizontalLocationPinsView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-03.
//

import SwiftUI
import MapKit

struct HorizontalLocationPinsView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(LocationPinsViewModel.self) private var savedPinsVM
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(LocationPinsModel.mock) {
                    LocationPinButtonView(title: $0.title) {
                        
                    }
                }
                .onPreferenceChange(savedPinsVM)
                
                MoreSavedLocationPinsButtonView()
            }
            .padding([.horizontal, .bottom])
            .padding(.top, 1)
        }
        .scrollIndicators(.never)
    }
}

// MARK: - PREVIEWS
#Preview("HorizontalLocationPinsView") {
    HorizontalLocationPinsView()
        .previewModifier()
}

#Preview("ContentView") {
    ContentView()
        .previewModifier()
}

// MARK: - EXTENSIONS
fileprivate extension View {
    func onPreferenceChange(_ savedPinsVM: LocationPinsViewModel) -> some View {
        self
            .background {
                GeometryReader { geo in
                    Color.clear
                        .preference(key: PinButtonPreferenceKey.self, value: geo.size.height)
                        .onPreferenceChange(PinButtonPreferenceKey.self) {
                            savedPinsVM.setHorizontalPinButtonsHeight($0)
                        }
                }
            }
    }
}
