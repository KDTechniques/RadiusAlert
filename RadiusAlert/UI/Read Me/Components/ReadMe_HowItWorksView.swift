//
//  ReadMe_HowItWorksView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-04.
//

import SwiftUI

struct ReadMe_HowItWorksView: View, ReadMeComponents {
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            titleText("⚙️ How It Works")
            step1
            step2
            step3
            step4
            step5
        }
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_HowItWorksView") {
    ReadMe_HowItWorksView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension ReadMe_HowItWorksView {
    private var step1: some View {
        VStack(alignment: .leading, spacing: 5) {
            subTitleText("1. Pick a Destination")
            bulletText("Search for your stop or drop a pin on the map.")
        }
    }
    
    private var step2: some View {
        VStack(alignment: .leading, spacing: 5) {
            subTitleText("2. Set Your Radius")
            bulletText("Choose how close you want to be notified (e.g., 700m, 1km).")
        }
    }
    
    private var step3: some View {
        VStack(alignment: .leading, spacing: 5) {
            subTitleText("3. Relax and Ride")
            bulletText("Put your iPhone away and enjoy your trip.")
            bulletText("You can still listen to music or podcasts — the app will gently pause the noise when it’s time to alert you.")
        }
    }
    
    private var step4: some View {
        VStack(alignment: .leading, spacing: 5) {
            subTitleText("4. Get Notified")
            bulletText("As soon as you reach your set radius, you’ll be alerted by:\n")
            
            VStack(alignment: .leading, spacing: 10) {
                let items: [BulletTextModel] = [
                    .init(emoji: "🚨", text: "Push notification"),
                    .init(emoji: "📳", text: "Haptic feedback "),
                    .init(emoji: "🔔", text: "Your chosen alert tone"),
                    .init(emoji: "📲", text: "On-screen popup\n")
                ]
                
                bulletTextForEach(items)
            }
            .padding(.leading, 40)
        }
    }
    
    private var step5: some View {
        VStack(alignment: .leading, spacing: 5) {
            subTitleText("5. Stay in Control")
            bulletText("Stop or adjust alerts anytime with a single tap.")
            
        }
    }
}
