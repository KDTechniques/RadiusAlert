//
//  PopupCardLocationTitleView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-09.
//

import SwiftUI

struct PopupCardLocationTitleView: View {
    // MARK: INJECTED PROEPRTIES
    let title: String?
    
    // MARK: - INITIALIZER
    init(title: String?) {
        self.title = title
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            icon
            locationTitle
        }
    }
}

// MARK: - PREVIEWS
#Preview("PopupCardLocationTitleView") {
    PopupCardLocationTitleView(title: "OneMac")
        .previewModifier()
}

// MARK: - EXTENSIONS
extension PopupCardLocationTitleView {
    private var icon: some View {
        Image(systemName: "mappin.and.ellipse")
            .symbolRenderingMode(.hierarchical)
            .resizable()
            .scaledToFit()
            .foregroundStyle(.red.gradient)
            .frame(width: 50)
    }
    
    @ViewBuilder
    private var locationTitle: some View {
        if let title {
            Text(title)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .font(.title3)
                .bold()
        }
    }
}
