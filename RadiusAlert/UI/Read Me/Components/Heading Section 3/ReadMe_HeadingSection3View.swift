//
//  ReadMe_HeadingSection3View.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-14.
//

import SwiftUI

struct ReadMe_HeadingSection3View: View {
    // MARK: - BODY
    var body: some View {
        heading
        description1
        image
        description2
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_HeadingSection3View") {
    VStack(alignment: .leading, spacing: 10) {
        ReadMe_HeadingSection3View()
    }
    .padding(.horizontal, ReadMe_Values.padding)
    .previewModifier()
}

// MARK: - EXTENSIONS
extension ReadMe_HeadingSection3View {
    private var heading: some View {
        Text("💤 Carefree Commuting")
            .readMeHeading1ViewModifier
            .readMeHeadingSectionToSectionPadding
    }
    
    private var description1: some View {
        Text("Nap, read, listen to music, or scroll TikTok worry-free.")
            .readMeBodyViewModifier
    }
    
    private var image: some View {
        Image.custom.ReadMe.heading_section3.image
            .resizable()
            .scaledToFit()
            .clipShape(.rect(cornerRadius: ReadMe_Values.cornerRadius))
            .padding(.vertical, ReadMe_Values.padding)
    }
    
    private var description2: some View {
        Text("The app runs quietly in the background and won’t interrupt your music — instead, it smoothly lowers the volume, plays the alert sound, and then restores your audio.")
            .readMeBodyViewModifier
    }
}
