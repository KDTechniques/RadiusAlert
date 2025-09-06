//
//  MatchedGeometryTestingView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-05.
//

import SwiftUI


enum AnimationTypes {
    case animation_1, animation_2, animation_3, animation_4
}

struct AnimationModel {
    let type: AnimationTypes
    var isInitialView:  Bool
    var showAnimation: Bool
    
    init(type: AnimationTypes, isInitialView: Bool = true, showAnimation: Bool = false) {
        self.type = type
        self.isInitialView = isInitialView
        self.showAnimation = showAnimation
    }
}

struct MatchedGeometryTestingView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    let action: () -> Void
    
    // MARK:- INITIALIZER
    init(_ action: @escaping () -> Void) {
        self.action = action
    }
    
    // MARK: - ASSIGNED PROPERTIES
    @State private var selectedAnimation: AnimationModel = .init(type: .animation_1)
    @Namespace private var namespace
    
    // MARK: - BODY
    var body: some View {
        Group {
            switch selectedAnimation.type {
            case .animation_1:
                if selectedAnimation.isInitialView { logoCircles } else { currentLocationNotation }
                
            case .animation_2:
                if selectedAnimation.isInitialView { currentLocationNotation } else { locationPin }
                
            case .animation_3:
                if selectedAnimation.isInitialView { locationPin } else { _3D }
                
            case .animation_4:
                if selectedAnimation.isInitialView { _3D } else { dismissButton }
            }
        }
        .frame(width: 40, height: 40)
        .onAppear { startAnimation() }
    }
}

//  MARK: - PREVIEWS
#Preview("MatchedGeometryTestingView") {
    MatchedGeometryTestingView {
        print("Dismissed!")
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension MatchedGeometryTestingView {
    private  func startAnimation() {
        Task {
            selectedAnimation.showAnimation = true
            try? await Task.sleep(nanoseconds: 3_500_000_000)
            withAnimation(.smooth(duration: 0.5)) {
                selectedAnimation.isInitialView = false
            }
            
            await triggerAnimation(for: .animation_2)
            await triggerAnimation(for: .animation_3)
            await triggerAnimation(for: .animation_4)
        }
    }
    
    private func triggerAnimation(for type: AnimationTypes) async {
        try? await Task.sleep(nanoseconds: 500_000_000)
        selectedAnimation = .init(type: type)
        withAnimation(.smooth(duration: 0.5)) {
            selectedAnimation.isInitialView = false
        }
    }
    
    private var logoCircles: some View {
        ZStack {
            Circle()
                .fill(.primary)
                .matchedGeometryEffect(id: "1", in: namespace)
                .frame(width: 40, height: 40)
            
            Circle()
                .fill(.primary)
                .matchedGeometryEffect(id: "2", in: namespace)
                .frame(width: 8, height: 8)
                .frame(width: 48, height: 48,  alignment: .bottomTrailing)
                .rotationEffect(.degrees(selectedAnimation.showAnimation ? 360 : 0))
                .animation(
                    .smooth(duration: 1).repeatCount(2, autoreverses: false),
                    value: selectedAnimation.showAnimation
                )
        }
    }
    
    private var currentLocationNotation: some View {
        Circle()
            .fill(.white)
            .matchedGeometryEffect(id: "1", in: namespace)
            .frame(width: 40, height: 40)
            .shadow(color: .black.opacity(0.5), radius: 1)
            .overlay {
                Circle()
                    .fill(.blue)
                    .padding(6.5)
                    .matchedGeometryEffect(id: "2", in: namespace)
            }
    }
    
    private var locationPin: some View {
        Image(systemName: "location.fill")
            .resizable()
            .scaledToFit()
            .matchedGeometryEffect(id: "2", in: namespace)
            .frame(width: 20, height: 20)
            .foregroundStyle(.blue)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
                    .matchedGeometryEffect(id: "1", in: namespace)
                    .frame(width: 40, height: 40)
                    .shadow(color: .black.opacity(0.1), radius: 2)
            }
    }
    
    private var _3D: some View {
        Text("3D")
            .font(.footnote)
            .fontWeight(.medium)
            .matchedGeometryEffect(id: "2", in: namespace)
            .frame(width: 20, height: 20)
            .foregroundStyle(.blue)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
                    .matchedGeometryEffect(id: "1", in: namespace)
                    .frame(width: 40, height: 40)
                    .shadow(color: .black.opacity(0.1), radius: 2)
            }
            .offset(x: -100)
    }
    
    private var dismissButton:some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .scaledToFit()
                .matchedGeometryEffect(id: "1", in: namespace)
                .frame(width: 40, height: 40)
        }
        .buttonStyle(.plain)
    }
}
