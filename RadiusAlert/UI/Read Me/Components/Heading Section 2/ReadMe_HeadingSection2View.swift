//
//  ReadMe_HeadingSection2View.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-14.
//

import SwiftUI

struct ReadMe_HeadingSection2View: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    // MARK: - BODY
    var body: some View {
        heading
        
        subHeading1
        hScrollCards(images: [.image1, .image2, .image3, .image4])
        
        subHeadingWithTopPadding("✏️ Edit Radius")
        hScrollCards(images: [.image5, .image6, .image7])
        
        subHeadingWithTopPadding("📌 Pin Frequent Stops")
        hScrollCards(images: [.image8, .image9, .image10, .image11])
        
        subHeadingWithTopPadding("🚏 Multiple Stops")
        hScrollCards(images: [.image12, .image13, .image14, .image15])
        
        subHeadingWithTopPadding("🗣️ Spoken Alert")
        hScrollCards(images: [.image16])
        
        subHeadingWithTopPadding("🛑 Auto Alert Stop")
        hScrollCards(images: [.image17])
        
        subHeadingWithTopPadding("🔊🎧 Alerts Only Via")
        hScrollCards(images: [.image18])
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_HeadingSection2View") {
    ScrollView(.vertical) {
        VStack(alignment: .leading, spacing: 10) {
            ReadMe_HeadingSection2View()
        }
        .padding(.horizontal, ReadMe_Values.padding)
    }
    .previewModifier()
}

// MARK: - EXTENSIONS
extension ReadMe_HeadingSection2View {
    private var heading: some View {
        Text("✨ Key Features")
            .readMeHeading2ViewModifier
            .readMeHeadingSectionToSectionPadding
    }
    
    private var subHeading1: some View {
        Text("🎯 Smart Radius Alerts")
            .readMeHeading1ViewModifier
    }
    
    private func subHeadingWithTopPadding(_ text: String) -> some View {
        Text(text)
            .readMeHeading1ViewModifier
            .readMeSubHeadingSectionToSectionPadding
    }
    
    private var card: some View {
        Rectangle()
            .fill(.regularMaterial)
            .frame(width: ReadMe_Values.cardWidth, height: ReadMe_Values.cardHeight)
    }
    
    private func image(_ type: ReadMe_HeadingSection2CardImageTypes) -> some View {
        type.image(colorScheme)
            .resizable()
            .scaledToFill()
            .frame(width: ReadMe_Values.cardWidth - ReadMe_Values.padding*3 )
            .scaleEffect(type.scaleEffect)
            .offset(x: type.offsetX, y: type.offsetY)
    }
    
    private func description(_ type: ReadMe_HeadingSection2CardImageTypes) -> some View {
        type.description
            .font(.footnote)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal, ReadMe_Values.padding)
    }
    
    private func hScrollCards(images: [ReadMe_HeadingSection2CardImageTypes]) -> some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: ReadMe_Values.padding) {
                ForEach(images, id: \.self) { type in
                    VStack(alignment: .leading, spacing: ReadMe_Values.padding) {
                        card
                            .overlay { image(type) }
                            .clipShape(.rect(cornerRadius: ReadMe_Values.cornerRadius))
                        
                        description(type)
                    }
                    .frame(width: ReadMe_Values.cardWidth)
                }
            }
            .padding(.horizontal, ReadMe_Values.padding)
            .scrollTargetLayout()
        }
        .padding(.horizontal, -ReadMe_Values.padding)
        .readMeAfterScrollTargetLayoutViewModifier
        .padding(.top, ReadMe_Values.padding)
    }
}
