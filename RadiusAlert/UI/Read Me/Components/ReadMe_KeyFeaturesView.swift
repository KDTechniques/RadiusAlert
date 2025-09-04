//
//  ReadMe_KeyFeaturesView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-04.
//

import SwiftUI

struct ReadMe_KeyFeaturesView: View, ReadMeComponents {
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            titleText("✨ Key Features")
            
            VStack(alignment: .leading, spacing: 40) {
                keyFeature1
                keyFeature2
                keyFeature3
                keyFeature4
                keyFeature5
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_KeyFeaturesView") {
    ReadMe_KeyFeaturesView()
        .previewModifier()
}

extension ReadMe_KeyFeaturesView {
    private var keyFeature1: some View {
        VStack(alignment: .leading, spacing: 10) {
            subTitleText("🎯 Smart Radius Alerts")
            bulletText("Pick your stop on the map or search for a location.")
            bulletText("Use the slider to set your custom radius — as small or as large as you want.")
            
            VStack(alignment:  .leading,  spacing: 5) {
                bulletText("When you enter your chosen radius, the app alerts you with:\n")
                
                VStack(alignment: .leading, spacing: 10) {
                    let items: [BulletTextModel] = [
                        .init(emoji: "🚨", text: "Push notification"),
                        .init(emoji: "📳", text: "Haptic feedback"),
                        .init(emoji: "🔔", text: "Your chosen alert tone"),
                        .init(emoji: "📲", text: "On-screen popup\n")
                    ]
                    
                    bulletTextForEach(items)
                }
                .padding(.leading, 40)
                
                bulletText("Note: Haptics (vibration) only trigger if your iPhone is unlocked.")
            }
        }
    }
    
    private var keyFeature2: some View {
        VStack(alignment: .leading, spacing: 10) {
            subTitleText("💤 Carefree Commuting")
            bulletText("Nap, read, listen to music, or scroll TikTok worry-free.")
            bulletText("The app runs quietly in the background and won’t interrupt your music — instead, it smoothly lowers the volume, plays the alert sound, and then restores your audio.")
        }
    }
    
    private var keyFeature3: some View {
        VStack(alignment: .leading, spacing: 10) {
            subTitleText("🔋 Battery-Friendly by Design")
            bulletText("Location updates are optimized for minimal battery drain.")
            bulletText("When your iPhone is locked, the app avoids unnecessary activity and only focwuses on delivering accurate alerts.")
        }
    }
    
    private var keyFeature4: some View {
        VStack(alignment: .leading, spacing: 10) {
            subTitleText("🚫 Distraction-Free")
            bulletText("No ads.")
            bulletText("No clutter.")
            bulletText("A clean, simple interface focused only on your journey.")
            bulletText("Dark Mode supported for comfortable night use.")
        }
    }
    
    private var keyFeature5: some View {
        VStack(alignment: .leading, spacing: 10) {
            subTitleText("🎵 More Control for You")
            bulletText("Choose your own alert tone.")
            bulletText("You decide if and when notifications are allowed — nothing happens without your consent.")
        }
    }
}
