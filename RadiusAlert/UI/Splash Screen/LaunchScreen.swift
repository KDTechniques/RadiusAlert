//
//  LaunchScreen.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-24.
//

import SwiftUI

struct LaunchScreen: View {
    // MARK: - ASSIGNED PROPERTIES
    @State var modelArray: [LaunchScreenLogoTextModel] = [
        .init(character: "R", opacity: 0),
        .init(character: "A", opacity: 0),
        .init(character: "D", opacity: 0),
        .init(character: "I", opacity: 0),
        .init(character: "U", opacity: 0),
        .init(character: "S", opacity: 0),
        .init(character: " ", opacity: 0),
        .init(character: "A", opacity: 0),
        .init(character: "L", opacity: 0),
        .init(character: "E", opacity: 0),
        .init(character: "R", opacity: 0),
        .init(character: "T", opacity: 0),
    ]
    
    // MARK: - BODY
    var body: some View {
        characters
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.background)
            .ignoresSafeArea()
            .onAppear { animate() }
    }
}

// MARK: - PREVIEWS
#Preview("Launch Screen") {
    LaunchScreen()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension LaunchScreen {
    private var characters: some View {
        HStack(spacing: 0) {
            ForEach(modelArray) { item in
                Text(item.character)
                    .opacity(item.opacity)
            }
        }
        .font(.title)
        .fontWeight(.heavy)
    }
    
    private func animate() {
        Task {
            for index in 0..<modelArray.count {
                withAnimation { modelArray[index].opacity = 1 }
                try? await Task.sleep(nanoseconds: 20_000_000)
            }
        }
    }
}
