//
//  AboutAppImprovementsView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-13.
//

import SwiftUI

struct AboutAppImprovementsView: View {
    // MARK: - BODY
    var body: some View {
        Section {
            ForEach(UpdateTypes.allCases, id: \.self) {
                AboutUpdatesView(type: $0)
            }
        } header: {
            Text("App Improvements")
        }
    }
}

// MARK: -  PREVIEWS
#Preview("About - App Improvements") {
    NavigationStack {
        List {
            AboutAppImprovementsView()
        }
    }
    .previewModifier()
}
