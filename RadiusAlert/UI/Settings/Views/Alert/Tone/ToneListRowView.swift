//
//  ToneListRowView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-19.
//

import SwiftUI

struct ToneListRowView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(SettingsViewModel.self) private var settingsVM
    let tone: ToneTypes
    
    // MARK: - INITIALIZER
    init(_ tone: ToneTypes) {
        self.tone = tone
    }
    
    // MARK: - BODY
    var body: some View {
        Button {
            settingsVM.setTone(tone)
            settingsVM.alertManager.playTone(tone.fileName, loopCount: 1)
        } label: {
            HStack {
                Text(tone.name)
                    .tint(.primary)
                
                Spacer()
                
                Image(systemName: settingsVM.selectedTone == tone ? "inset.filled.circle" : "circle")
                    .foregroundStyle(Color.accentColor)
            }
        }
        .onDisappear { handleOnDisappear() }
    }
}

// MARK: - PREVIEWS
#Preview("Tone List Row") {
    List {
        ToneListRowView(.defaultTone)
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension ToneListRowView {
    private func handleOnDisappear() {
        settingsVM.alertManager.stopTone()
    }
}
