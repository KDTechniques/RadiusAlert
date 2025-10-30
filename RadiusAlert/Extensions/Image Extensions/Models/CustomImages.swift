//
//  CustomImages.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-10-30.
//

import SwiftUI

enum CustomImages {
    enum About: CustomImagesProtocol {
        case developer
        
        var image: Image {
            switch self {
            case .developer:
                return Image(.developer)
            }
        }
    }
    
    enum SocialMediaIcons: CustomImagesProtocol {
        case facebook
        case whatsApp
        case linkedin
        case gitHub
        
        var image: Image {
            switch self {
            case .facebook:
                return Image(.facebook)
            case .whatsApp:
                return Image(.whatsApp)
            case .linkedin:
                return Image(.linkedin)
            case .gitHub:
                return Image(.gitHub)
            }
        }
    }
    
    enum ReadMe: CustomImagesProtocol {
        case heading_section1_1, heading_section1_2, heading_section1_3
        
        case heading_section2_1_dark, heading_section2_1_light
        case heading_section2_2_dark, heading_section2_2_light
        case heading_section2_3_dark, heading_section2_3_light
        case heading_section2_4_dark, heading_section2_4_light
        
        case heading_section3
        case heading_section6_dark, heading_section6_light
        case heading_section7
        
        case highlights_left_1_dark, highlights_left_1_light
        case highlights_left_2_dark, highlights_left_2_light
        case highlights_middle_dark, highlights_middle_light
        case highlights_right_1_dark, highlights_right_1_light
        case highlights_right_2_dark, highlights_right_2_light
        
        case introduction
        
        var image: Image {
            switch self {
            case .heading_section1_1:
                Image(.readMeHeadingSection1Image1)
            case .heading_section1_2:
                Image(.readMeHeadingSection1Image2)
            case .heading_section1_3:
                Image(.readMeHeadingSection1Image3)
            case .heading_section2_1_dark:
                Image(.readMeHeadingSection2Image1Dark)
            case .heading_section2_1_light:
                Image(.readMeHeadingSection2Image1Light)
            case .heading_section2_2_dark:
                Image(.readMeHeadingSection2Image2Dark)
            case .heading_section2_2_light:
                Image(.readMeHeadingSection2Image2Light)
            case .heading_section2_3_dark:
                Image(.readMeHeadingSection2Image3Dark)
            case .heading_section2_3_light:
                Image(.readMeHeadingSection2Image3Light)
            case .heading_section2_4_dark:
                Image(.readMeHeadingSection2Image4Dark)
            case .heading_section2_4_light:
                Image(.readMeHeadingSection2Image4Light)
            case .heading_section3:
                Image(.readMeHeadingSection3)
            case .heading_section6_dark:
                Image(.readMeHeadingSection6ImageDark)
            case .heading_section6_light:
                Image(.readMeHeadingSection6ImageLight)
            case .heading_section7:
                Image(.readMeHeadingSection7)
            case .highlights_left_1_dark:
                Image(.readMeHighlightsLeft1Dark)
            case .highlights_left_1_light:
                Image(.readMeHighlightsLeft1Light)
            case .highlights_left_2_dark:
                Image(.readMeHighlightsLeft2Dark)
            case .highlights_left_2_light:
                Image(.readMeHighlightsLeft2Light)
            case .highlights_middle_dark:
                Image(.readMeHighlightsMiddleDark)
            case .highlights_middle_light:
                Image(.readMeHighlightsMiddleLight)
            case .highlights_right_1_dark:
                Image(.readMeHighlightsRight1Dark)
            case .highlights_right_1_light:
                Image(.readMeHighlightsRight1Light)
            case .highlights_right_2_dark:
                Image(.readMeHighlightsRight2Dark)
            case .highlights_right_2_light:
                Image(.readMeHighlightsRight2Light)
            case .introduction:
                Image(.readMeIntroduction)
            }
        }
    }
}

protocol CustomImagesProtocol {
    var image: Image { get }
}
