//
//  PopupCardView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import SwiftUI

struct PopupCardView: View {
    // MARK: - INJECTED PROPERTIES
    let valuesArray: [PopupCardModel]
    let lastItemID: PopupCardDetailTypes?
    
    // MARK: - INITIALIZER
    init(valuesArray: [PopupCardModel]) {
        self.valuesArray = valuesArray
        lastItemID = valuesArray.last?.id
    }
    
    //MARK: - BODY
    var body: some View {
        VStack {
            PopupCardToolBarView()
            PopupCardTitlesView()
            PopupCardLocationTitleView(title: "Debug")
            Divider().padding(.vertical, 10)
            
            // Details
            HStack(spacing: 10) {
                ForEach(valuesArray) {
                    PopupCardDetailSectionView(
                        title: $0.type.rawValue,
                        systemImageName: $0.type.systemImageName,
                        value: $0.value,
                        foregroundColor: $0.type.foregroundColor
                    )
                    
                    if let lastItemID, lastItemID != $0.id {
                        verticalSeparator
                    }
                }
            }
            
            PopupCardCTAButtonView()
        }
        .padding()
        .background(.white, in: .rect(cornerRadius: 20))
        .padding(.horizontal, 50)
    }
}

// MARK: - PREVIEWS
#Preview("Popup Card") {
    PopupCardView(valuesArray: PopupCardModel.mockValues)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.regularMaterial)
        .ignoresSafeArea()
}

// MARK: - EXTENSIONS
extension PopupCardView {
    private var verticalSeparator: some View {
        Rectangle()
            .fill(Color(uiColor: .separator))
            .frame(width: 1,  height: 30)
    }
}
