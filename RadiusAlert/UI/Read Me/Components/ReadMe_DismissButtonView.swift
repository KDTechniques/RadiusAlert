//
//  ReadMe_DismissButtonView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-14.
//

import SwiftUI

struct ReadMe_DismissButtonView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(\.colorScheme)  private var colorScheme
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
            image
        }
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

// MARK: - EXTENSIONS
extension ReadMe_DismissButtonView {
    @ViewBuilder
    private var image: some View {
        if #available(iOS 26.0, *) {
            Image(systemName: "xmark")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .lightGray))
                .padding(12)
                .glassEffect(.clear, in: .circle)
                .shadow(radius: 1)
        } else {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(colorScheme == .dark
                                 ? Color.white
                                 : Color(uiColor: .lightGray)
                )
                .frame(width: 40, height: 40)
        }
    }
}
