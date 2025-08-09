//
//  PopupCardToolBarView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-09.
//

import SwiftUI

struct PopupCardToolBarView: View {
    // MARK: - BODY
    var body: some View {
        HStack {
            saveButton
            Spacer()
            dismissButton
        }
    }
}

// MARK: - PREVIEWS
#Preview("Popup Card ToolBar") {
    PopupCardToolBarView()
        .padding(.horizontal)
        .previewModifier()
}

// MARK: - EXTENSIONS
extension PopupCardToolBarView {
    private var saveButton: some View {
        Button("Save") {
            // save action goes here...
        }
    }
    
    private var dismissButton: some View {
        Button {
            // dismiss action goes here...
        } label: {
            Image(systemName: "xmark")
                .font(.footnote)
                .fontWeight(.heavy)
                .foregroundStyle(.secondary)
                .padding(7)
                .background(.regularMaterial, in: .circle)
        }
        .buttonStyle(.plain)
    }
}
