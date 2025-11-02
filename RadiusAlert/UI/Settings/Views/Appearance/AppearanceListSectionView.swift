//
//  AppearanceListSectionView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-19.
//

import SwiftUI

struct AppearanceListSectionView: View {
    // MARK: - BODY
    var body: some View {
        Section {
            ForEach(ColorSchemeTypes.allCases, id: \.self) {
                AppearanceListRowView($0)
            }
        } header: {
            Text("Dark Mode")
        }
    }
}

// MARK: - PREVIEWS
#Preview("AppearanceListSectionView") {
    NavigationStack {
        List {
            AppearanceListSectionView()
        }
    }
    .previewModifier()
}
