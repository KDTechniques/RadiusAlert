//
//  LocationPinLocalDatabaseManagerErrorModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-05.
//

import Foundation

enum LocationPinLocalDatabaseManagerErrorModel {
    case failedToCreateLocationPin(_ error: Error)
    case failedToFetchLocationPins(_ error: Error)
    case failedToUpdateLocationPins(_ error: Error)
    case failedToDeleteLocationPin(_ error: Error)
    
    var errorDescription: String {
        switch self {
        case .failedToCreateLocationPin(let error):
            return "❌: Failed to create location pin. \(error.localizedDescription)"
        case .failedToFetchLocationPins(let error):
            return "❌: Failed to fetch saved location pins from context. \(error.localizedDescription)"
        case .failedToUpdateLocationPins(let error):
            return "❌: failed to update location pin. \(error.localizedDescription)"
        case .failedToDeleteLocationPin(let error):
            return "❌: Failed to delete saved location pin from context. \(error.localizedDescription)"
        }
    }
}
