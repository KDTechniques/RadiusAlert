//
//  ReadMe_Highlights_ImageResourceValues.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-13.
//

import UIKit

struct ReadMe_Highlights_ImageResourceValues {
    private let hPadding: CGFloat
    
    init(hPadding: CGFloat) {
        self.hPadding = hPadding
    }
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private var availableWidth: CGFloat { screenWidth - hPadding*2 }
    private let middleImageToScreenWidthRatio: CGFloat = 2.8
    private let imageToImageWidthRatio: CGFloat = 1.15
    
    // Widths
    var middleImageWidth: CGFloat { availableWidth/middleImageToScreenWidthRatio }
    var leftRightImage1Width: CGFloat { middleImageWidth/imageToImageWidthRatio }
    var leftRightImage2Width: CGFloat { leftRightImage1Width/imageToImageWidthRatio }
    
    // Offsets
    var offsetFraction: CGFloat { middleImageToScreenWidthRatio }
    var offset1: CGFloat { middleImageWidth / offsetFraction }
    var offset2: CGFloat { middleImageWidth / offsetFraction * 2 }
}
