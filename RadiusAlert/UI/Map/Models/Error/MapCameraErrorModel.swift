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
    
    var errorDescription: String {
        switch self {
        case .failToGetInitialMapCameraPosition:
            return "❌: Failed to get initial map camera position."
            
        case .failedToSetNextMapStyle:
            return "❌: Failed to set next map camera due to array index issue."
        }
    }
}
