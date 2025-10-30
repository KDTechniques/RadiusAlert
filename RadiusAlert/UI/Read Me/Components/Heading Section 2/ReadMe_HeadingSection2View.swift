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
    
    // MARK: - ASSIGNED PROPERTIES
    private let values: ReadMe_Values.Type = ReadMe_Values.self
    
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
            RoundedRectangle(cornerRadius: values.cornerRadius)
                .fill(.regularMaterial)
                .frame(width: values.cardWidth, height: values.cardHeight)
        }
        
        func image(_ type: ReadMe_HeadingSection2CardImageTypes) -> some View {
            type.image(colorScheme)
                .resizable()
                .scaledToFill()
                .frame(width: values.cardWidth - values.padding*3 )
                .offset(y: type.offsetY)
        }
        
        func description(_ type: ReadMe_HeadingSection2CardImageTypes) -> some View {
            type.description
                .font(.footnote)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, values.padding)
        }
        
        return ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: values.padding) {
                ForEach(ReadMe_HeadingSection2CardImageTypes.allCases, id: \.self) { type in
                    VStack(alignment: .leading, spacing: values.padding) {
                        card
                            .overlay { image(type) }
                            .clipped()
                        
                        description(type)
                    }
                    .frame(width: values.cardWidth)
                }
            }
            .padding(.horizontal, values.padding)
            .scrollTargetLayout()
        }
        .padding(.horizontal, -values.padding)
        .readMeAfterScrollTargetLayoutViewModifier
        .padding(.top, values.padding)
    }
}
