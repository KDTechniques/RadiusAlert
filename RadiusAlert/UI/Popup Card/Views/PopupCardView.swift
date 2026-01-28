//
//  PopupCardView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import SwiftUI

struct PopupCardView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    let item: PopupCardModel
    
    // MARK: - INITIALIZER
    init(item: PopupCardModel) {
        self.item = item
    }
    
    //MARK: - BODY
    var body: some View {
        VStack {
            PopupCardToolBarView()
            PopupCardTitlesView()
            PopupCardLocationTitleView(title: item.locationTitle)
            
            Divider().padding(.vertical, 10)
            
            PopupCardDetailsView(item: item)
            PopupCardCTAButtonView(markerID: item.markerID)
        }
        .padding([.horizontal, .bottom])
        .glassEffectViewModifier
        .padding(.horizontal, 50)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial)
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEWS
#Preview("PopupCardView") {
    ZStack {
        ContentView()
        PopupCardView(item: .mockValues)
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
fileprivate extension View {
    @ViewBuilder
    var glassEffectViewModifier: some View {
        if #available(iOS 26.0, *) {
            self
                .glassEffect(.clear, in: .rect(cornerRadius: 35))
        } else {
            self
                .background(.background, in: .rect(cornerRadius: 20))
        }
    }
}
