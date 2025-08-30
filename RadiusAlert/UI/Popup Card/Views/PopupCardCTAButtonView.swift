//
//  PopupCardCTAButtonView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-09.
//

import SwiftUI

struct PopupCardCTAButtonView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        Button {
            mapVM.stopAlert()
        } label: {
            Text("OK")
                .tint(.primary)
                .fontWeight(.medium)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
        }
        .background(.regularMaterial, in: .rect(cornerRadius: 12))
        .padding(.top)
    }
}

// MARK: - PREVIEWS
#Preview("Popup Card CTA Button") {
    PopupCardCTAButtonView()
        .padding(.horizontal, 50)
        .previewModifier()
}
