//
//  UnavailableView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-17.
//

import SwiftUI

struct UnavailableView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(MapViewModel.self) private var mapVM
    let text: String
    
    // MARK: - INITIALIZER
    init(_ text: String) {
        self.text = text
    }
    
    // MARK: - BODY
    var body: some View {
        if mapVM.showNoInternetConnectionText() {
            Text(text)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 50)
        }
    }
}

// MARK: - PREVIEWS
#Preview("Unavailable") {
    UnavailableView("No Results")
        .previewModifier()
}
