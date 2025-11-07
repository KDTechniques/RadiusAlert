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
    @Environment(LocationPinsViewModel.self) private var locationPinsVM
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack {
                    ForEach(locationPinsVM.locationPinsArray) { item in
                        LocationPinButtonView(title: item.title) {
                            mapVM.prepareSelectedSearchResultCoordinateOnMap(item)
                        }
                    }
                    .onPreferenceChange(locationPinsVM)
                    
                    moreButton
                }
                .padding([.horizontal, .bottom])
                .padding(.top, 1)
                .id(locationPinsVM.scrollableHorizontalLocationPinsContentID)
            }
            .scrollIndicators(.never)
            .onChange(of: locationPinsVM.scrollPositionID) { _, newValue in
                withAnimation {
                    proxy.scrollTo(newValue, anchor: .trailing)
                }
            }
        }
        
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

extension HorizontalLocationPinsView  {
    @ViewBuilder
    private var moreButton: some View {
        if locationPinsVM.showMoreButton() {
            MoreSavedLocationPinsButtonView()
        }
    }
}
