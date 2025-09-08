//
//  ReadMe_MorphAnimationView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-05.
//

import SwiftUI

struct ReadMe_MorphAnimationView: View {
    // MARK: - ASSIGNED PROPERTIES
    @State private var selectedAnimation: ReadMeMorphAnimationModel = .init(type: .animation_1)
    @Namespace private var namespace
    
    // MARK: - BODY
    var body: some View {
        Group {
            switch selectedAnimation.type {
            case .animation_1:
                animation_1_Content
                
            case .animation_2:
                animation_2_Content
                
            case .animation_3:
                animation_3_Content
                
            case .animation_4:
                animation_4_Content
            }
        }
        .onAppear { startAnimations() }
    }
}

//  MARK: - PREVIEWS
#Preview("ReadMe_MorphAnimationView") {
    ReadMe_MorphAnimationView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension ReadMe_MorphAnimationView {
    @ViewBuilder
    private var animation_1_Content: some View {
        if selectedAnimation.isInitialView {
            ReadMe_MorphAnimation_LogoCircleView(
                namespace,
                showAnimation: selectedAnimation.showAnimation
            )
        } else {
            ReadMe_MorphAnimation_CurrentLocationNotationView(namespace)
        }
    }
    
    @ViewBuilder
    private var animation_2_Content: some View {
        if selectedAnimation.isInitialView {
            ReadMe_MorphAnimation_CurrentLocationNotationView(namespace)
        } else {
            ReadMe_MorphAnimation_LocationTriangleView(namespace)
        }
    }
    
    @ViewBuilder
    private var animation_3_Content: some View {
        if selectedAnimation.isInitialView {
            ReadMe_MorphAnimation_LocationTriangleView(namespace)
        } else {
            ReadMe_MorphAnimation_3DButtonView(namespace)
        }
    }
    
    @ViewBuilder
    private var animation_4_Content: some View {
        if selectedAnimation.isInitialView {
            ReadMe_MorphAnimation_3DButtonView(namespace)
        } else {
            ReadMe_MorphAnimation_TitleTextView(
                namespace,
                showAnimation: selectedAnimation.showAnimation
            )
        }
    }
    
    private  func startAnimations() {
        Task {
            await startAnimation_1()
            await startAnimation(for: .animation_2)
            await startAnimation(for: .animation_3)
            await startAnimation_4()
        }
    }
    
    private func startAnimation(for type: ReadMeMorphAnimationTypes) async {
        try? await Task.sleep(nanoseconds: .seconds(selectedAnimation.type.duration.initialDuration))
        selectedAnimation = .init(type: type)
        withAnimation(.smooth(duration: selectedAnimation.type.duration.secondaryDuration)) {
            selectedAnimation.isInitialView = false
        }
    }
    
    private func startAnimation_1() async {
        withAnimation(.smooth(duration: selectedAnimation.type.duration.initialDuration)) {
            selectedAnimation.showAnimation = true
        }
        try? await Task.sleep(nanoseconds: .seconds(selectedAnimation.type.duration.initialDuration))
        withAnimation(.smooth(duration: selectedAnimation.type.duration.secondaryDuration)) {
            selectedAnimation.isInitialView = false
        }
    }
    
    private func startAnimation_4() async {
        try? await Task.sleep(nanoseconds: .seconds(selectedAnimation.type.duration.initialDuration))
        selectedAnimation = .init(type: .animation_4)
        selectedAnimation.isInitialView = false
        withAnimation(.smooth(duration: selectedAnimation.type.duration.secondaryDuration)) {
            selectedAnimation.showAnimation = true
        }
    }
}
