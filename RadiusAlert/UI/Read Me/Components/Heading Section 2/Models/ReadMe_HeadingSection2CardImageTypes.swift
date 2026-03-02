//
//  ReadMe_HeadingSection2CardImageTypes.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-14.
//

import SwiftUI

enum ReadMe_HeadingSection2CardImageTypes: CaseIterable {
    case image1, image2, image3, image4
    
    func image(_ colorScheme: ColorScheme) -> Image {
        switch self {
        case .image1:
            return colorScheme == .dark ? .custom.ReadMe.heading_section2_1_dark.image : .custom.ReadMe.heading_section2_1_light.image
            
        case .image2:
            return colorScheme == .dark ? .custom.ReadMe.heading_section2_2_dark.image : .custom.ReadMe.heading_section2_2_light.image
            
        case .image3:
            return colorScheme == .dark ? .custom.ReadMe.heading_section2_3_dark.image : .custom.ReadMe.heading_section2_3_light.image
            
        case .image4:
            return colorScheme == .dark ? .custom.ReadMe.heading_section2_4_dark.image : .custom.ReadMe.heading_section2_4_light.image
        }
    }
    
    var description: Text {
        switch self {
        case .image1:
            return Text("**Pick your stop on the map.** Move the map to place your stop at least 1 km ahead of your current location. If it’s too close, the red pin won’t appear.")
            
        case .image2:
            return Text("**or Search for a location.** Use the search bar to find your stop, then select a result from the list.")
            
        case .image3:
            return Text("**Adjust circular radius.** Use the slider (700m to 3km) to set your preferred radius. You’ll be notified when you reach the edge of the circle.")
            
        case .image4:
            return  Text("**Get notified with push notifications.** When you enter your set destination radius, you’ll receive a notification — even if you’re browsing the web, scrolling through TikTok, or using other apps on your iPhone.")
        }
    }
    
    var offsetY: CGFloat {
        switch self {
        case .image1, .image2:
            return ReadMe_Values.cardHeight/4
            
        case .image3:
            return -ReadMe_Values.cardHeight/4
            
        case .image4:
            return .zero
        }
    }
}
