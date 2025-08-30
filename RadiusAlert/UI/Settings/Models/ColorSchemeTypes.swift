//
//  ColorSchemeTypes.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-19.
//

import SwiftUI

enum ColorSchemeTypes: String, CaseIterable {
    case dark, light, system
    
    // For list section labels
    var text: String {
        switch self {
        case .dark:
            return "On"
        case .light:
            return "Off"
        case .system:
            return self.rawValue.capitalized
        }
    }
    
    // For list section label descriptions
    var description: String? {
        switch self {
        case .system:
            return "We'll adjust your appearance based on your device's system settings."
            
        default:
            return nil
        }
    }
    
    var colorScheme: ColorScheme? {
        switch self {
        case .dark:
            return .dark
        case .light:
            return .light
        case .system:
            return nil
        }
    }
}
