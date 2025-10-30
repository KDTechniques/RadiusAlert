//
//  ReadMe_Highlights_ImageResourceTypes.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-13.
//

import SwiftUI

enum ReadMe_Highlights_ImageResourceTypes: CaseIterable {
    case readMeHighlightsLeft2, readMeHighlightsLeft1, readMeHighlightsMiddle, readMeHighlightsRight1, readMeHighlightsRight2
    
    func imageResource(_ colorScheme: ColorScheme) -> Image {
        let highlights: CustomImages.ReadMe.Type = CustomImages.ReadMe.self
        
        switch self {
        case .readMeHighlightsLeft2:
            return colorScheme ==  .dark ? highlights.highlights_left_2_dark.image : highlights.highlights_left_2_light.image
            
        case .readMeHighlightsLeft1:
            return colorScheme ==  .dark ? highlights.highlights_left_1_dark.image : highlights.highlights_left_1_light.image
            
        case .readMeHighlightsMiddle:
            return colorScheme ==  .dark ? highlights.highlights_middle_dark.image : highlights.highlights_middle_light.image
            
        case .readMeHighlightsRight1:
            return colorScheme ==  .dark ? highlights.highlights_right_1_dark.image : highlights.highlights_right_1_light.image
            
        case .readMeHighlightsRight2:
            return colorScheme ==  .dark ? highlights.highlights_right_2_dark.image : highlights.highlights_right_2_light.image
        }
    }
    
    func width(_ values: ReadMe_Highlights_ImageResourceValues) -> CGFloat {
        switch self {
        case .readMeHighlightsLeft2, .readMeHighlightsRight2:
            return values.leftRightImage2Width
            
        case .readMeHighlightsMiddle:
            return values.middleImageWidth
            
        case .readMeHighlightsLeft1, .readMeHighlightsRight1:
            return values.leftRightImage1Width
        }
    }
    
    func initialOffsetX(_ values: ReadMe_Highlights_ImageResourceValues) -> CGFloat {
        let firstImageOffset: CGFloat = values.leftRightImage1Width + (values.middleImageWidth-values.leftRightImage1Width)/2
        let secondImageOffset: CGFloat = values.leftRightImage1Width + (values.middleImageWidth-values.leftRightImage1Width)/2 + values.leftRightImage2Width + (values.leftRightImage1Width-values.leftRightImage2Width)/2
        
        switch self {
        case .readMeHighlightsLeft2:
            return secondImageOffset
            
        case .readMeHighlightsLeft1:
            return firstImageOffset
            
        case .readMeHighlightsMiddle:
            return .zero
            
        case .readMeHighlightsRight1:
            return -firstImageOffset
            
        case .readMeHighlightsRight2:
            return -secondImageOffset
        }
    }
    
    func secondaryOffsetX(_ values: ReadMe_Highlights_ImageResourceValues)  -> CGFloat {
        switch self {
        case .readMeHighlightsLeft2:
            return values.offset2
            
        case .readMeHighlightsLeft1:
            return values.offset1
            
        case .readMeHighlightsMiddle:
            return .zero
            
        case .readMeHighlightsRight1:
            return -values.offset1
            
        case .readMeHighlightsRight2:
            return -values.offset2
        }
    }
    
    var zIndex: Double {
        switch self {
        case .readMeHighlightsLeft2, .readMeHighlightsRight2:
            return 0
            
        case .readMeHighlightsLeft1, .readMeHighlightsRight1:
            return 1
            
        case .readMeHighlightsMiddle:
            return 2
        }
    }
}
