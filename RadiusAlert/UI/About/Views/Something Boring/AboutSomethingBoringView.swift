//
//  AboutSomethingBoringView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-13.
//

import SwiftUI

struct AboutSomethingBoringView: View {
    // MARK: - BODY
    var body: some View {
        Section {
            AboutOriginView()
            AboutReadMeView()
        } header: {
            Text("Something Boring")
        } footer: {
            Text("Made with ❤️ in Sri Lanka 🇱🇰".uppercased())
                .padding(.vertical)
        }
    }
}

// MARK: - PREVIEWS
#Preview("About - Something Boring") {
    NavigationStack {
        List {
            AboutSomethingBoringView()
        }
    }
    .previewModifier()
}
