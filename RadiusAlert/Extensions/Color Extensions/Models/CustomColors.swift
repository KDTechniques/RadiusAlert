//
//  CustomColors.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-16.
//

import SwiftUI

enum CustomColors {
    enum Map {
        case mapControlButtonBackground
        
        var color: Color {
            switch self {
            case .mapControlButtonBackground:
                return .mapControlButtonBackground
            }
        }
    }
    
    enum SearchBar {
        case searchBarBackground
        case searchBarForeground
        
        var color: Color {
            switch self {
            case .searchBarBackground:
                return .searchBarBackground
                
            case .searchBarForeground:
                return .searchBarForeground
            }
        }
    }
}
