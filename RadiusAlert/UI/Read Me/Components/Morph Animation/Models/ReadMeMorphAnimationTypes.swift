//
//  ReadMeMorphAnimationTypes.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-08.
//

import Foundation

enum ReadMeMorphAnimationTypes {
    case animation_1, animation_2, animation_3, animation_4
    
    var duration: (initialDuration: Double, secondaryDuration: Double) {
        switch self {
        case .animation_1:
            return (1, 0.5)
            
        default:
            return (0.5, 0.5)
        }
    }
}
