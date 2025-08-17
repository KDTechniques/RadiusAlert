//
//  AboutConnectWithDeveloperView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-13.
//

import SwiftUI

struct AboutConnectWithDeveloperView: View {
    // MARK: - ASSIGNED PROPERTIES
    let socialMediaTypes: [OpenURLTypes] = [.whatsApp, .facebook, .gitHub]
    
    // MARK: - BODY
    var body: some View {
        NavigationLink {
            List {
                ForEach(socialMediaTypes, id: \.self) {
                    AboutConnectSocialMediaLinkView(type: $0)
                }
            }
            .navigationTitle(Text("Connect with Kavinda"))
            .navigationBarTitleDisplayMode(.inline)
        } label: {
            Text("Connect with Kavinda 👋")
        }
    }
}

// MARK: - PREVIEWS
#Preview("About - Connect with Developer") {
    NavigationStack {
        AboutConnectWithDeveloperView()
    }
    .previewModifier()
}
