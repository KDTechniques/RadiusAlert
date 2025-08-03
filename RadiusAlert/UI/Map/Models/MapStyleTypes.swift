//
//  MapStyleTypes.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-08-03.
//

import SwiftUI
import MapKit

enum MapStyleTypes: CaseIterable {
    case standard, hybrid, imagery
    
    var mapStyle: MapStyle {
        switch self {
        case .standard:
            return .standard
        case .imagery:
            return .imagery
        case .hybrid:
            return .hybrid
        }
    }
    
    var mapStyleSystemImageName: String {
        switch self {
        case .standard:
            return "square.3.layers.3d.bottom.filled"
        case .imagery:
            return "square.3.layers.3d.top.filled"
        case .hybrid:
            return "square.3.layers.3d.middle.filled"
        }
    }
}

