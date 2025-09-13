//
//  ReadMe_HeadingSection2CardImageTypes.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-14.
//

import SwiftUI

enum ReadMe_HeadingSection2CardImageTypes: CaseIterable {
    case image1, image2, image3
    
    func imageResource(_ colorScheme: ColorScheme) -> ImageResource {
        switch self {
        case .image1:
            return colorScheme == .dark ? .readMeHeadingSection2Image1Dark : .readMeHeadingSection2Image1Light
            
        case .image2:
            return colorScheme == .dark ? .readMeHeadingSection2Image2Dark : .readMeHeadingSection2Image2Light
            
        case .image3:
            return colorScheme == .dark ? .readMeHeadingSection2Image3Dark : .readMeHeadingSection2Image3Light
        }
    }
    
    var description: Text {
        switch self {
        case .image1:
            return Text("**Pick your stop on the map.** Move the map to place your stop at least 1 km ahead of your current location. If it’s too close, the red pin won’t appear.")
            
        case .image2:
            return Text("**or Search for a location.** Use the search bar to find your stop, then select a result from the list.")
            
        case .image3:
            return Text("**Adjust Circular Radius.** Use the slider (700m to 3km) to set your preferred radius. You’ll be notified when you reach the edge of the circle.")
        }
    }
    
    var offsetY: CGFloat {
        let values: ReadMe_Values.Type = ReadMe_Values.self
        
        switch self {
        case .image1, .image2:
            return values.cardHeight/4
            
        case .image3:
            return -values.cardHeight/4
        }
    }
}
