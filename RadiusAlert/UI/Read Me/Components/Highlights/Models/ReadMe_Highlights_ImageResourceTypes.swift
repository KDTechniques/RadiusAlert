//
//  ReadMe_Highlights_ImageResourceTypes.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-13.
//

import SwiftUI

enum ReadMe_Highlights_ImageResourceTypes: CaseIterable {
    case highlightsLeft2, highlightsLeft1, highlightsMiddle, highlightsRight1, highlightsRight2
    
    func imageResource(_ colorSceherme: ColorScheme) -> ImageResource {
        switch self {
        case .highlightsLeft2:
            return colorSceherme ==  .dark ? .highlightsLeft2Dark : .highlightsLeft2Light
        case .highlightsLeft1:
            return colorSceherme ==  .dark ? .highlightsLeft1Dark : .highlightsLeft1Light
        case .highlightsMiddle:
            return colorSceherme ==  .dark ? .highlightsMiddleDark : .highlightsMiddleLight
        case .highlightsRight1:
            return colorSceherme ==  .dark ? .highlightsRight1Dark : .highlightsRight1Light
        case .highlightsRight2:
            return colorSceherme ==  .dark ? .highlightsRight2Dark : .highlightsRight2Light
        }
    }
    
    func width(_ values: ReadMe_Highlights_ImageResourceValues) -> CGFloat {
        switch self {
        case .highlightsLeft2, .highlightsRight2:
            return values.leftRightImage2Width
            
        case .highlightsMiddle:
            return values.middleImageWidth
            
        case .highlightsLeft1, .highlightsRight1:
            return values.leftRightImage1Width
        }
    }
    
    func initialOffsetX(_ values: ReadMe_Highlights_ImageResourceValues) -> CGFloat {
        let firstImageOffset: CGFloat = values.leftRightImage1Width + (values.middleImageWidth-values.leftRightImage1Width)/2
        let secondImageOffset: CGFloat = values.leftRightImage1Width + (values.middleImageWidth-values.leftRightImage1Width)/2 + values.leftRightImage2Width + (values.leftRightImage1Width-values.leftRightImage2Width)/2
        
        switch self {
        case .highlightsLeft2:
            return secondImageOffset
            
        case .highlightsLeft1:
            return firstImageOffset
            
        case .highlightsMiddle:
            return .zero
            
        case .highlightsRight1:
            return -firstImageOffset
            
        case .highlightsRight2:
            return -secondImageOffset
        }
    }
    
    func secondaryOffsetX(_ values: ReadMe_Highlights_ImageResourceValues)  -> CGFloat {
        switch self {
        case .highlightsLeft2:
            return values.offset2
            
        case .highlightsLeft1:
            return values.offset1
            
        case .highlightsMiddle:
            return .zero
            
        case .highlightsRight1:
            return -values.offset1
            
        case .highlightsRight2:
            return -values.offset2
        }
    }
    
    var zIndex: Double {
        switch self {
        case .highlightsLeft2, .highlightsRight2:
            return 0
            
        case .highlightsLeft1, .highlightsRight1:
            return 1
            
        case .highlightsMiddle:
            return 2
        }
    }
}
