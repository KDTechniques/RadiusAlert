//
//  ReadMe_HeadingSection7View.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-14.
//

import SwiftUI

struct ReadMe_HeadingSection7View: View {
    // MARK: - ASSIGNED PROPERTIES
    private let values: ReadMe_Values.Type = ReadMe_Values.self
    
    // MARK: - BODY
    var body: some View {
        heading
        description
        image
        footerSubHeading
        footerDescription
    }
}

// MARK: - PREVIEWS
#Preview("ReadMe_HeadingSection7View") {
    VStack(alignment: .leading, spacing: 10) {
        ReadMe_HeadingSection7View()
    }
    .padding(.horizontal, ReadMe_Values.padding)
    .previewModifier()
}

// MARK: - EXTENSIONS
extension ReadMe_HeadingSection7View {
    private var heading: some View {
        Text("🧠 Memory-Friendly")
            .readMeHeading1ViewModifier
            .readMeHeadingSectionToSectionPadding
    }
    
    private var description: some View {
        Text("The live map is removed when not needed, keeping the app light — using only about 0–1% of your phone’s processing power and around 150MB of memory.")
            .readMeBodyViewModifier
    }
    
    private var image: some View {
        Image.custom.ReadMe.heading_section7.image
            .resizable()
            .scaledToFit()
            .clipShape(.rect(cornerRadius: values.cornerRadius))
            .padding(.vertical, values.padding)
    }
    
    private var footerSubHeading: some View {
        Text("Radius Alert lets you travel with peace of mind. ⚡")
            .readMeHeading2ViewModifier
    }
    
    private var footerDescription: some View {
        Text("No stress. No missed stops. Just set it, forget it, and ride worry-free.")
            .readMeBodyViewModifier
    }
}
