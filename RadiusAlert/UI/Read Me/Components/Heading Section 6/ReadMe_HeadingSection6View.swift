//
//  ReadMe_HeadingSection6View.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-14.
//

import SwiftUI

struct ReadMe_HeadingSection6View: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - ASSIGNED PROPERTIES
    private let values: ReadMe_Values.Type = ReadMe_Values.self
    private let bullets: [ReadMe_HeadingSection6BulletModel] = [
        .init(emoji: "📍", text: "Destination name (if searched)"),
        .init(emoji: "📏", text: "Distance traveled"),
        .init(emoji: "🎯", text: "Your chosen radius"),
        .init(emoji: "⏱️", text: "Time it took")
    ]
    
    // MARK: - BODY
    var body: some View {
        heading
        subHeading
        description
        bulletPoints
        image
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_HeadingSection6View") {
    VStack(alignment: .leading, spacing: 10) {
        ReadMe_HeadingSection6View()
    }
    .padding(.horizontal, ReadMe_Values.padding)
    .previewModifier()
}

// MARK: - EXTENSIONS
extension ReadMe_HeadingSection6View {
    private var heading: some View {
        Text("🧩 UX Choices That Matter")
            .readMeHeading2ViewModifier
            .readMeHeadingSectionToSectionPadding
    }
    
    private var subHeading: some View {
        Text("📲 Alert Popup")
            .readMeHeading1ViewModifier
    }
    
    private var description: some View {
        Text("When you arrive, the popup shows useful details at a glance:")
            .readMeBodyViewModifier
    }
    
    private var bulletPoints: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(bullets) { bullet in
                HStack(alignment: .top) {
                    Text(bullet.emoji)
                    Text(bullet.text)
                }
            }
        }
        .readMeBodyViewModifier
        .padding(.top, values.padding)
    }
    
    private var image: some View {
        Image(colorScheme == .dark ? .readMeHeadingSection6ImageDark : .readMeHeadingSection6ImageLight)
            .resizable()
            .scaledToFit()
            .shadow(color: .primary.opacity(0.3), radius: 1)
            .frame(width: values.cardWidth)
            .frame(maxWidth: .infinity)
            .padding(.vertical, values.padding)
    }
}
