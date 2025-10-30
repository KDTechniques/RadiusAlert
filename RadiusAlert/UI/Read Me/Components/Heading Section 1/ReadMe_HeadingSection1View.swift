//
//  ReadMe_HeadingSection1View.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-13.
//

import SwiftUI



struct ReadMe_HeadingSection1View: View {
    // MARK: - ASSIGNED PROPERTIES
    private let values: ReadMe_Values.Type = ReadMe_Values.self
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let cards: [ReadMe_HeadingSection1CardModel] = [
        .init(emoji: "😴", text: "Falling asleep during your ride", image: .custom.ReadMe.heading_section1_1.image),
        .init(emoji: "😨", text: "Missing your stop", image: .custom.ReadMe.heading_section1_2.image),
        .init(emoji: "🚶‍♂️", text: "Having to walk (or pay extra) just to get back", image: .custom.ReadMe.heading_section1_3.image)
    ]
    private var overlayHeight: CGFloat { values.cardHeight / 4.5 }
    
    // MARK: - BODY
    var body: some View {
        title
        description
        hScrollCards
        footer
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_HeadingSection1View") {
    VStack(alignment: .leading, spacing: 10) {
        ReadMe_HeadingSection1View()
    }
    .padding(.horizontal, ReadMe_Values.padding)
    .previewModifier()
}

// MARK: - EXTENSIONS
extension ReadMe_HeadingSection1View {
    private var title: some View {
        Text("🚌 Why Radius Alert?")
            .readMeHeading1ViewModifier
    }
    
    private var description: some View {
        Text("If you’ve ever dozed off or gotten lost in your iPhone on a commute, you know the fear:")
            .readMeBodyViewModifier
    }
    
    private var hScrollCards: some View {
        func image(_ card: ReadMe_HeadingSection1CardModel) -> some View {
            card.image
                .resizable()
                .scaledToFill()
                .frame(width: values.cardWidth, height: values.cardHeight)
        }
        
        var overlay: some View {
            Color.black.opacity(0.3)
                .frame(height: overlayHeight)
        }
        
        func overlayText(_ card: ReadMe_HeadingSection1CardModel) -> some View {
            HStack(alignment: .top, spacing: 5) {
                Text(card.emoji)
                Text(card.text)
            }
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding()
        }
        
        return ScrollView(.horizontal) {
            HStack(spacing: values.padding) {
                ForEach(cards) { card in
                    image(card)
                        .overlay(alignment: .top) { overlay }
                        .clipShape(.rect(cornerRadius: values.cornerRadius))
                        .overlay(alignment: .topLeading) { overlayText(card) }
                }
            }
            .padding(.horizontal, values.padding)
            .scrollTargetLayout()
        }
        .readMeAfterScrollTargetLayoutViewModifier
        .padding(.vertical, values.padding)
        .padding(.horizontal, -values.padding)
    }
    
    private var footer: some View {
        Text("Radius Alert takes that stress away. Just set your stop, relax, listen to music, even take a nap and the app will wake you up right on time.")
            .readMeBodyViewModifier
    }
}
