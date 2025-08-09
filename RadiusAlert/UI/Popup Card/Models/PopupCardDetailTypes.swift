//
//  PopupCardDetailTypes.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-09.
//

import SwiftUI

enum PopupCardDetailTypes: String {
    case radius, duration, distance
    
    var title: String {
        switch self {
        case .radius:
            return "Radius"
        case .duration:
            return "Duration"
        case .distance:
            return "Distance"
        }
    }
    
    var systemImageName: String {
        switch self {
        case .radius:
            return "circle.circle.fill"
        case .duration:
            return "stopwatch.fill"
        case .distance:
            return"point.topleft.down.to.point.bottomright.curvepath.fill"
        }
    }
    
    var foregroundColor: Color {
        switch  self {
        case .radius:
            return .red
        default:
            return .black
        }
    }
}
