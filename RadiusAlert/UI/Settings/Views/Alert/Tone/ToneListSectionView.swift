//
//  ToneListSectionView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-19.
//

import SwiftUI

struct ToneListSectionView: View {
    // MARK: - BODY
    var body: some View {
        List {
            Section {
                ForEach(ToneTypes.allCases, id: \.self) {
                    ToneListRowView($0)
                }
            } header: {
                Text("Select Radius Alert Tone")
            }
        }
        .navigationTitle(Text("Tone"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - PREVIEWS
#Preview("Tone List Section") {
    NavigationStack {
        ToneListSectionView()
    }
    .previewModifier()
}
