//
//  ReadMe_DismissButtonView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-08.
//

import SwiftUI

struct ReadMe_DismissButtonView: View {
    // MARK: - INJECTED PROPERTIES
    let action: () -> Void
    
    // MARK: - INITIALIZER
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    // MARK: - BODY
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.white)
                .frame(width: 40, height: 40)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_DismissButtonView") {
    Color.black
        .ignoresSafeArea()
        .overlay {
            ReadMe_DismissButtonView {
                print("Dismissed!")
            }
        }
        .previewModifier()
}
