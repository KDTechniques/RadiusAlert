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
        subHeading
        hScrollCards
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_HeadingSection2View") {
    VStack(alignment: .leading, spacing: 10) {
        ReadMe_HeadingSection2View()
    }
    .padding(.horizontal, ReadMe_Values.padding)
    .previewModifier()
}

// MARK: - EXTENSIONS
extension ReadMe_HeadingSection2View {
    private var heading: some View {
        Text("✨ Key Features")
            .readMeHeading2ViewModifier
            .readMeHeadingSectionToSectionPadding
    }
    
    private var subHeading: some View {
        Text("🎯 Smart Radius Alerts")
            .readMeHeading1ViewModifier
    }
    
    private var hScrollCards: some View {
        var card: some View {
            RoundedRectangle(cornerRadius: ReadMe_Values.cornerRadius)
                .fill(.regularMaterial)
                .frame(width: ReadMe_Values.cardWidth, height: ReadMe_Values.cardHeight)
        }
        
        func image(_ type: ReadMe_HeadingSection2CardImageTypes) -> some View {
            type.image(colorScheme)
                .resizable()
                .scaledToFill()
                .frame(width: ReadMe_Values.cardWidth - ReadMe_Values.padding*3 )
                .offset(y: type.offsetY)
        }
        
        func description(_ type: ReadMe_HeadingSection2CardImageTypes) -> some View {
            type.description
                .font(.footnote)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, ReadMe_Values.padding)
        }
        
        return ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: ReadMe_Values.padding) {
                ForEach(ReadMe_HeadingSection2CardImageTypes.allCases, id: \.self) { type in
                    VStack(alignment: .leading, spacing: ReadMe_Values.padding) {
                        card
                            .overlay { image(type) }
                            .clipped()
                        
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
