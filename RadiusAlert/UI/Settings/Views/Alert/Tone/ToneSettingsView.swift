//
//  ToneSettingsView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-10-28.
//

import SwiftUI

struct ToneSettingsView: View {
    // MARK: - BODY
    var body: some View {
        List {
            ToneListSectionView()
            ToneFadeSectionView()
        }
        .navigationTitle(Text("Tone"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - PREVIEWS
#Preview("ToneSettingsView") {
    ToneSettingsView()
        .previewModifier()
}
