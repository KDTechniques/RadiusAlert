//
//  AboutAppStoreRateView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-23.
//

import SwiftUI

struct AboutAppStoreRateView: View {
    // MARK: - BODY
    var body: some View {
        Section {
            HStack {
                Button("Share Your Experience") {
                    OpenURLTypes.appStore.openURL()
                }
                
                Spacer()
                
                Image(systemName: "apple.logo")
            }
        } footer: {
            Text("If Radius Alert ever saved your stop — maybe while you were asleep — leaving a review helps others discover the app and benefit from it too.")
        }
    }
}

// MARK: = PREVIEWS
#Preview("About App Store Rate") {
    List {
        AboutAppStoreRateView()
    }
    .previewModifier()
}
