//
//  KeyboardPreLoaderView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-08.
//

import SwiftUI

struct KeyboardPreLoaderView: View {
    // MARK: - ASSIGNED PROPERTIES
    @FocusState private var isFocused: Bool
    @State private var showKeyboardPreLoader: Bool = true
    
    // MARK: - BODY
    var body: some View {
        if showKeyboardPreLoader {
            TextField("", text: .constant(""))
                .focused($isFocused)
                .onAppear {
                    Task {
                        isFocused = true
                        try? await Task.sleep(nanoseconds: 100_000_000)
                        isFocused = false
                        showKeyboardPreLoader = false
                    }
                }
        }
    }
}

// MARK: - PREVIEWS
#Preview("Keyboard Pre-Loader") {
    KeyboardPreLoaderView()
        .previewModifier()
}
