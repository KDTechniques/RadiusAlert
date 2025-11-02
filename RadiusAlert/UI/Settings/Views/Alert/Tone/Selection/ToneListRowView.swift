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
        let condition: Bool = settingsVM.selectedTone == tone
        
        Custom_RadioButtonListRowView(isSelected: condition) {
            Text(tone.name)
                .tint(.primary)
        } action: {
            settingsVM.setTone(tone)
            settingsVM.alertManager.playTone(tone.fileName, loopCount: 1)
        }
        .onDisappear { handleOnDisappear() }
    }
}

// MARK: - PREVIEWS
#Preview("ToneListRowView") {
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
