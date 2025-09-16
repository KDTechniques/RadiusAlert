//
//  ReadMe_IntroductionView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-13.
//

import SwiftUI

struct ReadMe_IntroductionView: View {
    // MARK: - INJECTED PROPERTIES
    @Binding var animate: Bool
    
    // MARK: - INITIALIZER
    init(animate: Binding<Bool>) {
        _animate = animate
    }
    
    // MARK: - BODY
    var body: some View {
        image
            .overlay(alignment: .bottom) { blurEffectImage }
            .overlay { description }
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_IntroductionView") {
    ReadMe_IntroductionView(animate: .constant(true))
        .previewModifier()
}

// MARK: - EXTENSIONS
extension ReadMe_IntroductionView {
    private var image: some View {
        Image(.readMeIntroduction)
            .resizable()
            .scaledToFit()
    }
    
    private var blurEffectImage: some View {
        Image(.readMeIntroduction)
            .resizable()
            .scaledToFit()
            .mask(alignment: .bottom) {
                Rectangle()
                    .frame(height: 200)
            }
            .blur(radius: 5)
            .clipped()
    }
    
    private var description: some View {
        VStack(spacing: 10) {
            ReadMe_MorphAnimationView { animate = true }
            
            Text("Radius Alert is an iOS app designed to solve a simple but common problem: falling asleep or getting distracted during your bus or train ride and missing your stop.")
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .font(.callout)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(30)
    }
}
