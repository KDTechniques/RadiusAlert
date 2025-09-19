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
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(colorScheme == .dark
                                 ? Color.white
                                 : Color(uiColor: .lightGray)
                )
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
