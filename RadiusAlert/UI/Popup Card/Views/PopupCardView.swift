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
#if DEBUG
            PopupCardToolBarView()
#endif
            PopupCardTitlesView()
            PopupCardLocationTitleView(title: item.locationTitle)
            
            Divider().padding(.vertical, 10)
            
            PopupCardDetailsView(item: item)
            PopupCardCTAButtonView()
        }
        .padding()
        .background(.background, in: .rect(cornerRadius: 20))
        .padding(.horizontal, 50)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial)
        .ignoresSafeArea()
    }
}

// MARK: - PREVIEWS
#Preview("Popup Card") {
    PopupCardView(item: .mockValues)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.regularMaterial)
        .ignoresSafeArea()
        .previewModifier()
}
