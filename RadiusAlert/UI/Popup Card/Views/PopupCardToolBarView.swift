//
//  PopupCardToolBarView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-09.
//

import SwiftUI

struct PopupCardToolBarView: View {
    @State private var isSaved: Bool = false
    
    // MARK: - BODY
    var body: some View {
        Button {
            // save action goes here...
            isSaved.toggle()
        } label: {
            Image(systemName: isSaved ? "checkmark.circle.fill" : "pin.fill")
                .font(.title3)
                .foregroundStyle(isSaved ? Color.green.gradient : Color.gray.gradient)
                .contentTransition(.symbolEffect(.replace))
        }
        .buttonStyle(.plain)
        .frame(height: 25)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .disabled(true)
        .opacity(0)
    }
}

// MARK: - PREVIEWS
#Preview("Popup Card ToolBar") {
    PopupCardToolBarView()
        .padding(.horizontal)
        .previewModifier()
}
