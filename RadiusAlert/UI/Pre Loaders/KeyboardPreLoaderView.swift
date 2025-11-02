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
    let onKeyboardLoaderFinish: () -> Void
    
    init(onKeyboardLoaderFinish: @escaping () -> Void) {
        self.onKeyboardLoaderFinish = onKeyboardLoaderFinish
    }
    
    // MARK: - BODY
    var body: some View {
        TextField("", text: .constant(""))
            .focused($isFocused)
            .disabled(true)
            .allowsHitTesting(false)
            .opacity(0)
            .tint(.clear)
            .foregroundStyle(.clear)
            .onAppear { handleOnAppear() }
    }
}

// MARK: - PREVIEWS
#Preview("KeyboardPreLoaderView") {
    KeyboardPreLoaderView {
        print("Keyboard Loader is Finished!")
    }
    .previewModifier()
}

#Preview("KeyboardPreLoaderView - Content") {
    ContentView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension KeyboardPreLoaderView {
    private func handleOnAppear() {
        Task {
            isFocused = true
            try? await Task.sleep(nanoseconds: 500_000_000)
            isFocused = false
            onKeyboardLoaderFinish()
        }
    }
}
