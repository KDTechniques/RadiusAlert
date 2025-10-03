//
//  UnavailableView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-17.
//

import SwiftUI

struct UnavailableView: View {
    // MARK: - INJECTED PROPERTIES
    let text: String
    let foregroundColor:  Color
    
    // MARK: - INITIALIZER
    init(_ text: String, foregroundColor: Color = .secondary) {
        self.text = text
        self.foregroundColor = foregroundColor
    }
    
    // MARK: - BODY
    var body: some View {
        Text(text)
            .fontWeight(.semibold)
            .foregroundStyle(foregroundColor)
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 50)
    }
}

// MARK: - PREVIEWS
#Preview("Unavailable") {
    UnavailableView("No Results")
        .previewModifier()
}
