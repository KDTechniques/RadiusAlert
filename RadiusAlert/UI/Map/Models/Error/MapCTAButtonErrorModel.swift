//
//  MapCTAButtonErrorModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-10.
//

import Foundation

enum MapCTAButtonErrorModel {
    case userAlreadyInRadius
    case failedToStartMonitoringRegion
    case failedToGetDistance
    case failedToExecuteOnRegionEntry
    case failedToExecuteOnRegionEntryFailure
    
    var errorDescription: String {
        switch self {
        case .userAlreadyInRadius:
            return "⚠️: User is already in the circular radius range."
        case .failedToStartMonitoringRegion:
            return "❌: Failed to start monitoring region due to marker coordinate being nil."
        case .failedToGetDistance:
            return "❌: Failed to get distance due to current user location being nil."
        case .failedToExecuteOnRegionEntry:
            return "❌: Failed to execute on region entry due to self is bing nil."
        case .failedToExecuteOnRegionEntryFailure:
            return "❌: Failed to execute on region entry failure."
        }
    }
}

