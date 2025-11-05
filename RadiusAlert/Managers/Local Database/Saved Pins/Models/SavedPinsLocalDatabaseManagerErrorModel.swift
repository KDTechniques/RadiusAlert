//
//  SavedPinsLocalDatabaseManagerErrorModel.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-05.
//

import Foundation

enum SavedPinsLocalDatabaseManagerErrorModel: LocalizedError {
    case failedToCreateNewLocationPin(_ error: Error)
    case failedToFetchSavedLocationPins(_ error: Error)
    case failedToUpdateLocationPins(_ error: Error)
    case failedToDeleteSavedLocationPin(_ error: Error)
    
    var errorDescription: String? {
        switch self {
        case .failedToCreateNewLocationPin(let error):
            return "❌: Failed to create new location pin. \(error.localizedDescription)"
        case .failedToFetchSavedLocationPins(let error):
            return "❌: Failed to fetch saved location pins from context. \(error.localizedDescription)"
        case .failedToUpdateLocationPins(let error):
            return "❌: failed to update location pins. \(error.localizedDescription)"
        case .failedToDeleteSavedLocationPin(let error):
            return "❌: Failed to delete saved location pins from context. \(error.localizedDescription)"
        }
    }
}
