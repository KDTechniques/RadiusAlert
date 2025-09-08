//
//  ReadMe_MorphAnimation_LogoCircleView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-08.
//

import SwiftUI

struct ReadMe_MorphAnimation_LogoCircleView: View {
    // MARK: - INJECTED PROPERTIES
    let namespace: Namespace.ID
    let showAnimation: Bool
    
    // MARK: - INITIALIZER
    init(_ namespace: Namespace.ID, showAnimation: Bool) {
        self.namespace = namespace
        self.showAnimation = showAnimation
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            bigCircle
            smallCircle
        }
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_MorphAnimation_LogoCircleView") {
    Preview()
        .previewModifier()
}

fileprivate struct Preview: View {
    @Namespace private var namespace
    @State private var showAnimation: Bool = false
    
    var body: some View {
        VStack(spacing: 50) {
            ReadMe_MorphAnimation_LogoCircleView(namespace, showAnimation: showAnimation)
            
            Button("Show Animation") {
                showAnimation.toggle()
            }
        }
    }
}

// MARK: - EXTENSIONS
extension ReadMe_MorphAnimation_LogoCircleView {
    private var bigCircle: some View {
        Circle()
            .fill(.white)
            .matchedGeometryEffect(id: 1, in: namespace)
            .frame(width: 30)
    }
    
    private var smallCircle: some View {
        Circle()
            .fill(.white)
            .matchedGeometryEffect(id: 2, in: namespace)
            .frame(width: 5,height: 5)
            .frame(width: 38, height: 38,  alignment: .bottomTrailing)
            .rotationEffect(.degrees(showAnimation ? 360 : 0))
    }
}
