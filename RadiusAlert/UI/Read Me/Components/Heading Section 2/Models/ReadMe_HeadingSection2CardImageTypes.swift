//
//  ReadMe_HeadingSection2CardImageTypes.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-14.
//

import SwiftUI

enum ReadMe_HeadingSection2CardImageTypes: CaseIterable {
    case image1, image2, image3, image4
    case image5, image6, image7
    case image8, image9, image10, image11
    case image12, image13, image14, image15
    case image16
    case image17
    case image18
    
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
            
        case .image5:
            return colorScheme == .dark ? .custom.ReadMe.heading_section2_5_dark.image : .custom.ReadMe.heading_section2_5_light.image
            
        case .image6:
            return colorScheme == .dark ? .custom.ReadMe.heading_section2_6_dark.image : .custom.ReadMe.heading_section2_6_light.image
            
        case .image7:
            return colorScheme == .dark ? .custom.ReadMe.heading_section2_7_dark.image : .custom.ReadMe.heading_section2_7_light.image
            
        case .image8:
            return colorScheme == .dark ? .custom.ReadMe.heading_section2_8_dark.image : .custom.ReadMe.heading_section2_8_light.image
            
        case .image9:
            return colorScheme == .dark ? .custom.ReadMe.heading_section2_9_dark.image : .custom.ReadMe.heading_section2_9_light.image
            
        case .image10:
            return colorScheme == .dark ? .custom.ReadMe.heading_section2_10_dark.image : .custom.ReadMe.heading_section2_10_light.image
            
        case .image11:
            return colorScheme == .dark ? .custom.ReadMe.heading_section2_11_dark.image : .custom.ReadMe.heading_section2_11_light.image
            
        case .image12:
            return colorScheme == .dark ? .custom.ReadMe.heading_section2_12_dark.image : .custom.ReadMe.heading_section2_12_light.image
            
        case .image13:
            return colorScheme == .dark ? .custom.ReadMe.heading_section2_13_dark.image : .custom.ReadMe.heading_section2_13_light.image
            
        case .image14:
            return colorScheme == .dark ? .custom.ReadMe.heading_section2_14_dark.image : .custom.ReadMe.heading_section2_14_light.image
            
        case .image15:
            return colorScheme == .dark ? .custom.ReadMe.heading_section2_15_dark.image : .custom.ReadMe.heading_section2_15_light.image
            
        case .image16:
            return colorScheme == .dark ? .custom.ReadMe.heading_section2_16_dark.image : .custom.ReadMe.heading_section2_16_light.image
            
        case .image17:
            return colorScheme == .dark ? .custom.ReadMe.heading_section2_17_dark.image : .custom.ReadMe.heading_section2_17_light.image
            
        case .image18:
            return colorScheme == .dark ? .custom.ReadMe.heading_section2_18_dark.image : .custom.ReadMe.heading_section2_18_light.image
        }
    }
    
    var description: Text {
        switch self {
        case .image1:
            return .init("**Pick your stop on the map.** Move the map to place your stop at least 1 km ahead of your current location. If it’s too close, the red pin won’t appear.")
            
        case .image2:
            return .init("**or Search for a location.** Use the search bar to find your stop, then select a result from the list.")
            
        case .image3:
            return Text("**Adjust circular radius.** Use the slider (700m to 3km) to set your preferred radius. You’ll be notified when you reach the edge of the circle.")
            
        case .image4:
            return  .init("**Get notified with push notifications.** When you enter your set destination radius, you’ll receive a notification even if you’re browsing the web, scrolling through TikTok, or using other apps on your iPhone.")
            
        case .image5:
            return  .init("**Tap the 'Pencil' button.** This shows a list of all the stops you’ve set on the map.")
            
        case .image6:
            return .init("**Choose a stop to adjust its radius.**")
            
        case .image7:
            return .init("**Use the slider to adjust the radius.** The map updates automatically.")
            
        case .image8:
            return Text("**Search or manually set a stop on the map.** Use the search bar to find a frequent stop and select it from the list.")
            
        case .image9:
            return Text("**Tap the 'Pin' button.** Once the stop appears on the map, or after moving the map to your desired stop, tap 'Pin' to save it as a frequent stop.")
            
        case .image10:
            return Text("**Rename it as you like.** Use a short, simple name so it’s easy to recognize. Then set the radius to your preference.")
            
        case .image11:
            return Text("**Pinned stops appear under the search bar.** Instead of searching or manually moving the map around for the same stops every day, pin frequent stops and access them easily with one tap.")
            
        case .image12:
            return Text("**Tap the '+' button.** If you already have a stop on the map and want to add another, tap the '+' button. You can also tap a pinned stop under the search bar, if available.")
            
        case .image13:
            return Text("**Search or set a stop manually.** You can either search for a stop or manually move the map around to add another stop.")
            
        case .image14:
            return Text("**Tap the 'Add' button.** You can set multiple stops on the secondary map. Once your other stop appears, or after you manually set it on the secondary map, tap 'Add' and dismiss the secondary map.")
            
        case .image15:
            return Text("**Activated multiple stops appear on the primary map.** Once you set your other stops and dismiss the secondary map, they appear on the primary map with their assigned numbers and radius alerts activated.")
            
        case .image16:
            return Text("**Enter your name.** When you reach your destination stop, the app speaks your name and lets you know that you've reached your destination. Go to Settings > Spoken Alert")
            
        case .image17:
            return Text("**You're totally hands free.** Alerts automatically stop after a set duration once they are triggered at your destination stop. The app first speaks your name, notifies you that you've reached your destination, plays the alert tone, and finally dismisses itself, so you don't have to take your phone out of your pocket.")
            
        case .image18:
            return Text("**Doubt and worry free.** If you're uncomfortable hearing alerts from your iPhone speaker on public transport, you can set alerts to play only through a connected device so you only hear them through your headphones.")
        }
    }
    
    var offsetY: CGFloat {
        switch self {
        case .image1, .image2, .image8, .image10, .image14, .image16, .image17, .image18:
            return ReadMe_Values.cardHeight/4
            
        case .image3, .image6, .image7, .image13, .image15:
            return -ReadMe_Values.cardHeight/4
            
        case .image4:
            return .zero
            
        case .image5, .image12:
            return -ReadMe_Values.cardHeight/1.2
            
        case .image9:
            return -ReadMe_Values.cardWidth/1.7
            
        case .image11:
            return ReadMe_Values.cardHeight/1.4
        }
    }
    
    var offsetX: CGFloat {
        switch self {
        case .image5, .image12:
            return -ReadMe_Values.cardWidth/2.3
            
        case .image9:
            return -ReadMe_Values.cardWidth/4.5
            
        case .image11:
            return -ReadMe_Values.cardWidth/2.8
            
        default:
            return .zero
        }
    }
    
    var scaleEffect: CGFloat {
        switch self {
        case .image5, .image12:
            return 2
            
        case .image9:
            return 1.4
            
        case .image11:
            return 1.8
            
        default:
            return 1.0
        }
    }
}
