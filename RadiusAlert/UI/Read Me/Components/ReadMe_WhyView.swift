//
//  ReadMe_WhyView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-04.
//

import SwiftUI

struct ReadMe_WhyView: View, ReadMeComponents {
    // MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            titleText("🚌 Why Radius Alert?")
            
            descriptionText("If you’ve ever dozed off or gotten lost in your iPhone on a commute, you know the fear:\n")
            
            let bullets: [BulletTextModel] = [
                .init(emoji: "😴", text: "Falling asleep during your ride."),
                .init(emoji: "😨", text: "Missing your stop."),
                .init(emoji: "🚶‍♂️", text: "Having to walk (or pay extra) just to get back.")
            ]
            
            bulletTextForEach(bullets)
            
            descriptionText("\nRadius Alert takes that stress away. Just set your stop, relax, listen to music, even take a nap — and the app will wake you up right on time.")
        }
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_WhyView") {
    ReadMe_WhyView()
        .previewModifier()
}
