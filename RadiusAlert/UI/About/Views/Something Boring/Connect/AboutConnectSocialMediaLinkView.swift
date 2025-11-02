//
//  AboutConnectSocialMediaLinkView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-13.
//

import SwiftUI

struct AboutConnectSocialMediaLinkView: View {
    // MARK: - INJECTED PROPERTIES
    let type: OpenURLTypes
    
    //MARK: - INITIALIZER
    init(type: OpenURLTypes) {
        self.type = type
    }
    
    //MARK: - BODY
    var body: some View {
        HStack {
            button
            Spacer()
            icon
        }
    }
}

// MARK: - PREVIEWS
#Preview("About - Connect Social Media Link") {
    List {
        AboutConnectSocialMediaLinkView(type: .facebook)
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension AboutConnectSocialMediaLinkView {
    private var button: some View {
        Button(type.rawValue) { type.openURL() }
    }
    
    @ViewBuilder
    private var icon: some View {
        if let icon: ImageResource = type.icon {
            Image(icon)
                .resizable()
                .scaledToFit()
                .frame(height: 20)
            
        }
    }
}
