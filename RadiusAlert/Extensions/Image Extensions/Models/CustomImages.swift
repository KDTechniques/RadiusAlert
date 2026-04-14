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
        
        case heading_section2_5_dark, heading_section2_5_light
        case heading_section2_6_dark, heading_section2_6_light
        case heading_section2_7_dark, heading_section2_7_light
        
        case heading_section2_8_dark, heading_section2_8_light
        case heading_section2_9_dark, heading_section2_9_light
        case heading_section2_10_dark, heading_section2_10_light
        case heading_section2_11_dark, heading_section2_11_light
        
        case heading_section2_12_dark, heading_section2_12_light
        case heading_section2_13_dark, heading_section2_13_light
        case heading_section2_14_dark, heading_section2_14_light
        case heading_section2_15_dark, heading_section2_15_light
        
        case heading_section2_16_dark, heading_section2_16_light
        
        case heading_section2_17_dark, heading_section2_17_light
        
        case heading_section2_18_dark, heading_section2_18_light
        
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
                // MARK: Heading Section 1
            case .heading_section1_1:
                Image(.readMeHeadingSection1Image1)
            case .heading_section1_2:
                Image(.readMeHeadingSection1Image2)
            case .heading_section1_3:
                Image(.readMeHeadingSection1Image3)
                
                // MARK: Heading Section 2
                // Sub Section 1
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
                
                // Sub Section 2
            case .heading_section2_5_dark:
                Image(.readMeHeadingSection2Image5Dark)
            case .heading_section2_5_light:
                Image(.readMeHeadingSection2Image5Light)
            case .heading_section2_6_dark:
                Image(.readMeHeadingSection2Image6Dark)
            case .heading_section2_6_light:
                Image(.readMeHeadingSection2Image6Light)
            case .heading_section2_7_dark:
                Image(.readMeHeadingSection2Image7Dark)
            case .heading_section2_7_light:
                Image(.readMeHeadingSection2Image7Light)
                
                // Sub Section 3
            case .heading_section2_8_dark:
                Image(.readMeHeadingSection2Image8Dark)
            case .heading_section2_8_light:
                Image(.readMeHeadingSection2Image8Light)
            case .heading_section2_9_dark:
                Image(.readMeHeadingSection2Image9Dark)
            case .heading_section2_9_light:
                Image(.readMeHeadingSection2Image9Light)
            case .heading_section2_10_dark:
                Image(.readMeHeadingSection2Image10Dark)
            case .heading_section2_10_light:
                Image(.readMeHeadingSection2Image10Light)
            case .heading_section2_11_dark:
                Image(.readMeHeadingSection2Image11Dark)
            case .heading_section2_11_light:
                Image(.readMeHeadingSection2Image11Light)
                
                // Sub Section 4
            case .heading_section2_12_dark:
                Image(.readMeHeadingSection2Image12Dark)
            case .heading_section2_12_light:
                Image(.readMeHeadingSection2Image12Light)
            case .heading_section2_13_dark:
                Image(.readMeHeadingSection2Image13Dark)
            case .heading_section2_13_light:
                Image(.readMeHeadingSection2Image13Light)
            case .heading_section2_14_dark:
                Image(.readMeHeadingSection2Image14Dark)
            case .heading_section2_14_light:
                Image(.readMeHeadingSection2Image14Light)
            case .heading_section2_15_dark:
                Image(.readMeHeadingSection2Image15Dark)
            case .heading_section2_15_light:
                Image(.readMeHeadingSection2Image15Light)
                
                // Sub Section 5
            case .heading_section2_16_dark:
                Image(.readMeHeadingSection2Image16Dark)
            case .heading_section2_16_light:
                Image(.readMeHeadingSection2Image16Light)
                
                // Sub Section 6
            case .heading_section2_17_dark:
                Image(.readMeHeadingSection2Image17Dark)
            case .heading_section2_17_light:
                Image(.readMeHeadingSection2Image17Light)
                
                // Sub Section 7
            case .heading_section2_18_dark:
                Image(.readMeHeadingSection2Image18Dark)
            case .heading_section2_18_light:
                Image(.readMeHeadingSection2Image18Light)
                
                // MARK: Heading Section 3
            case .heading_section3:
                Image(.readMeHeadingSection3)
                
                // MARK: Heading Section 6
            case .heading_section6_dark:
                Image(.readMeHeadingSection6ImageDark)
            case .heading_section6_light:
                Image(.readMeHeadingSection6ImageLight)
                
                // MARK: Heading Section 7
            case .heading_section7:
                Image(.readMeHeadingSection7)
                
                // MARK: Highlights
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
                
                // MARK: Introduction
            case .introduction:
                Image(.readMeIntroduction)
            }
        }
    }
}

protocol CustomImagesProtocol {
    var image: Image { get }
}
