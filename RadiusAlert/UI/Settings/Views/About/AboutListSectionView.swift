//
//  AboutListSectionView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-13.
//

import SwiftUI

struct AboutListSectionView: View {
    // MARK: - BODY
    var body: some View {
        Section {
            NavigationLink {
                AboutView()
            } label: {
                Text("About")
            }
        } header: {
            Text("Learn More")
        }
    }
}

// MARK: - PREVIEWS
#Preview("AboutListSectionView") {
    NavigationStack {
        List {
            AboutListSectionView()
        }
    }
    .previewModifier()
}
