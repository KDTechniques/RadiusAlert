//
//  LogoView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-24.
//

import SwiftUI

struct LogoView: View {
    // MARK: - INJECTED PROPERTIES
    let color: Color
    let size: CGFloat
    
    // MARK: - INITIALIZER
    init(color: Color, size: CGFloat) {
        self.color = color
        self.size = size
    }
    
    // MARK: - ASSIGNED PROPERTIES
    let defaultBigCircleHeight: CGFloat = 28
    let defaultSmallCircleHeight: CGFloat = 5
    let defaultFrameSize: CGFloat = 35
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            bigCircle
            smallCircle
        }
        .foregroundStyle(color)
        .frame(width: size, height: size)
    }
}

// MARK: - PREVIEWS
#Preview("LogoView") {
    LogoView(color: MapViewModel(settingsVM: .init()).getNavigationTitleIconColor(), size: 150)
        .previewModifier()
}

// MARK: - EXTENSIONS
extension LogoView {
    private var bigCircle: some View {
        Circle()
            .frame(height: size/defaultFrameSize*defaultBigCircleHeight)
    }
    
    private var smallCircle: some View {
        Circle()
            .frame(height: size/defaultFrameSize*defaultSmallCircleHeight)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    }
}
