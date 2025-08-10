//
//  MapCameraErrorModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-10.
//

import Foundation

enum MapCameraErrorModel {
    case failToGetInitialMapCameraPosition
    case failedToSetNextMapStyle
    case failedToCenterRegionBoundsForMarkerNUserLocation
    
    var errorDescription: String {
        switch self {
        case .failToGetInitialMapCameraPosition:
            return "❌: Failed to get initial map camera position."
        case .failedToSetNextMapStyle:
            return "❌: Failed to set next map camera due to array index issue."
        case .failedToCenterRegionBoundsForMarkerNUserLocation:
            return "❌: Failed to center region bounds for both marker and current user location."
        }
    }
}
