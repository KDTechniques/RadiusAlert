//
//  AboutListRowView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-13.
//

import SwiftUI

struct AboutListRowView: View {
    // MARK: - ASSIGNED PROPERTIES
    let primaryText: String
    let secondaryText: String
    
    // MARK: - INITIALIZER
    init(_ primaryText: String, _ secondaryText: String) {
        self.primaryText = primaryText
        self.secondaryText = secondaryText
    }
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Text(primaryText)
            Spacer()
            Text(secondaryText).foregroundStyle(.secondary)
        }
    }
}

// MARK: - PREVIEWS
#Preview("About List Row") {
    List {
        AboutListRowView("Version", "1.0.0")
    }
    .previewModifier()
}
