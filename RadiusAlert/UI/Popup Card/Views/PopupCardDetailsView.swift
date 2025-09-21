//
//  PopupCardDetailsView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-09.
//

import SwiftUI

struct PopupCardDetailsView: View {
    // MARK: - INJECTED PROPERTIES
    let item: PopupCardModel
    let lastItemID: PopupCardDetailTypes?
    
    // MARK: - INITIALIZER
    init(item: PopupCardModel) {
        self.item = item
        lastItemID = item.typeNValue.last?.type
    }
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 10) {
            ForEach(item.typeNValue, id: \.type) {
                PopupCardDetailSectionView(
                    title: $0.type.rawValue,
                    systemImageName: $0.type.systemImageName,
                    value: $0.value,
                    foregroundColor: $0.type.foregroundColor
                )
                
                if let lastItemID, lastItemID != $0.type {
                    verticalSeparator
                }
            }
        }
    }
}

//MARK: - PREVIEWS
#Preview("Popup Card Details") {
    PopupCardDetailsView(item: .mockValues)
        .previewModifier()
}

// MARK: - EXTENSIONS
extension PopupCardDetailsView {
    private var verticalSeparator: some View {
        Rectangle()
            .fill(.secondary)
            .frame(width: 1,  height: 30)
    }
}
