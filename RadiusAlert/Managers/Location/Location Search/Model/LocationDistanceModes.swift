//
//  LocationDistanceModes.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-21.
//

import CoreLocation

enum LocationDistanceModes: String  {
    case close    // < 1km
    case medium   // 1–3km
    case far      // 3–10km
    case veryFar  // > 10km
    
    static func getMode(for distance: CLLocationDistance) -> Self {
        switch distance {
        case ..<1_000:
            return .close
            
        case 1_000..<3_000:
            return .medium
            
        case 3_000..<10_000:
            return .far
            
        default:
            return .veryFar
        }
    }
}
