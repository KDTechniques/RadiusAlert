//
//  AboutOriginView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-13.
//

import SwiftUI

struct AboutOriginView: View {
    // MARK: - BODY
    var body: some View {
        NavigationLink {
            List {
                Section {
                    Text(AboutOriginStrings.getOriginString())
                } header: {
                    Text("The Story Behind the App")
                }
            }
            .navigationTitle(Text("Origin"))
            .navigationBarTitleDisplayMode(.inline)
        } label: {
            Text("Origin 👨🏻‍💻")
        }
    }
}

// MARK: - PREVIEWS
#Preview("About - Origin") {
    NavigationStack {
        AboutOriginView()
    }
    .previewModifier()
}
