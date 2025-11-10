//
//  LocationPinsVMErrorModel.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-07.
//

import Foundation

enum LocationPinsVMErrorModel {
    case failedToInitializeLocationPinsVM(Error)
    case failedToCreateNewLocationPin(Error)
    case failedToFetchNSetLocationPinArray(Error)
    case failedToMoveLocationPinListItem(Error)
    case failedToDeleteLocationPinListItem(Error)
    
    var errorDescription: String {
        switch self {
        case .failedToInitializeLocationPinsVM(let error):
            return "❌: Error initializing Location Pins View Model. \(error.localizedDescription)"

        case .failedToCreateNewLocationPin(let error):
            return "❌: Error creating a new location pin. \(error.localizedDescription)"
            
        case.failedToFetchNSetLocationPinArray(let error):
            return "❌: Error fetching and setting location pins array from database. \(error.localizedDescription)"
            
        case .failedToMoveLocationPinListItem(let error):
            return "❌: Error moving location pin item in the list. \(error.localizedDescription)"
            
        case .failedToDeleteLocationPinListItem(let error):
            return "❌: Error deleting location pin item in the list. \(error.localizedDescription)"
        }
    }
}
