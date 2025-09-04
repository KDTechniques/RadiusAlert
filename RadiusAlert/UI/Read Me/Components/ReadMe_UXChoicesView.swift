//
//  ReadMe_UXChoicesView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-04.
//

import SwiftUI

struct ReadMe_UXChoicesView: View, ReadMeComponents {
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            titleText("🧩 UX Choices That Matter")
            
            VStack(alignment: .leading, spacing: 40) {
                choice1
                choice2
                choice3
                choice4
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_UXChoicesView") {
    ReadMe_UXChoicesView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension ReadMe_UXChoicesView {
    private var choice1: some View {
        VStack(alignment: .leading, spacing: 10) {
            subTitleText("📲 Alert Popup")
            bulletText("When you arrive, the popup shows useful details at a glance:\n")
            
            VStack(alignment: .leading, spacing: 10) {
                let items: [BulletTextModel] = [
                    .init(emoji: "📍", text: "Destination name"),
                    .init(emoji: "📏", text: "Distance traveled"),
                    .init(emoji: "🎯", text: " Your chosen radius"),
                    .init(emoji: "⏱️", text: "Time it took")
                ]
                
                bulletTextForEach(items)
            }
            .padding(.leading, 40)
        }
    }
    
    private var choice2: some View {
        VStack(alignment: .leading, spacing: 10) {
            subTitleText("🧠 Memory-Friendly")
            bulletText("The live map is removed when not needed, keeping the app light — using only about 0–1% of your phone’s processing power and around 150MB of memory.")
        }
    }
    
    private var choice3: some View {
        VStack(alignment: .leading, spacing: 10) {
            subTitleText("🛡️ User-First Approach")
            bulletText("You’re only asked for notification permission when you actually need it.")
            bulletText("Map interactions are limited once an alert is active, preventing unnecessary battery or memory usage.")
        }
    }
    
    private var choice4: some View {
        VStack(alignment: .leading, spacing: 10) {
            subTitleText("Radius Alert lets you travel with peace of mind. ⚡")
            
            Text("No stress. No missed stops. Just set it, forget it, and ride worry-free.")
                .fontWeight(.semibold)
        }
    }
}
