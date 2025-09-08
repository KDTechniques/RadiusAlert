//
//  ReadMe_MorphAnimation_TitleTextView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-08.
//

import SwiftUI

struct ReadMe_MorphAnimation_TitleTextView: View {
    // MARK: - INJECTED PROPERTIES
    let namespace: Namespace.ID
    let showAnimation: Bool
    
    // MARK: - INITIALIZER
    init(_ namespace: Namespace.ID, showAnimation: Bool) {
        self.namespace = namespace
        self.showAnimation = showAnimation
    }
    
    //MARK: - BODY
    var body: some View {
        ReadMe_TitleTextView()
            .foregroundStyle(.white)
            .mask(alignment:  .leading) {
                Rectangle()
                    .frame(maxWidth: showAnimation ? .infinity : 0)
            }
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_MorphAnimation_TitleTextView") {
    Color.black
        .ignoresSafeArea()
        .overlay {
            Preview()
        }
        .previewModifier()
}

fileprivate struct Preview: View {
    @Namespace private var namespace
    @State private var showAnimation: Bool = false
    
    var body: some View {
        VStack(spacing: 50) {
            ReadMe_MorphAnimation_TitleTextView(namespace, showAnimation: showAnimation)
            
            Button("Show Animation") {
                withAnimation {
                    showAnimation.toggle()
                }
            }
        }
    }
}
