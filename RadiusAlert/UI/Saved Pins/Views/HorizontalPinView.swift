//
//  HorizontalPinView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-03.
//

import SwiftUI

struct HorizontalPinView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(SavedPinsViewModel.self) private var savedPinsVM
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(PinModel.mock) {
                    PinButtonView(title: $0.getLabel(), action: { })
                }
                .onPreferenceChange(savedPinsVM)
                
                MoreSavedPinsButtonView()
            }
            .padding([.horizontal, .bottom])
            .padding(.top, 1)
        }
        .scrollIndicators(.never)
    }
}

// MARK: - PREVIEWS
#Preview("HorizontalPinView") {
    HorizontalPinView()
        .previewModifier()
}

#Preview("ContentView") {
    ContentView()
        .previewModifier()
}

// MARK: - EXTENSIONS
fileprivate extension View {
    func onPreferenceChange(_ savedPinsVM: SavedPinsViewModel) -> some View {
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
